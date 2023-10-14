import { Request, Response } from 'express';
import mailApi from '../util/api/mail';
import { Mail } from '../models/mail';
import {
  GetMailsSettings,
  MailAccount,
  MailRequest,
} from '../models/mail_interfaces';
import { isValidEmail } from '../util/validation';

export async function sendMail(req: any, res: Response) {
  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  const mailReq: MailRequest = { mail: req.body, auth };

  if (mailReq.mail.to == null || mailReq.mail.to.length <= 0) {
    return res.status(400).json({ response: 'No emails to send' });
  }
  for (const to of mailReq.mail.to) { 
    if (!isValidEmail(to)) {
      return res.status(400).json({ response: 'Format is invalid!' });
    }
  }

  const info = await mailApi.sendMail(mailReq);

  res.status(200).json({ response: 'Message sent: ' + info.response });
}

export async function getMails(req: Request, res: Response) {
  let { fetchSlice, mailbox } = req.query;
  const settings = { fetchSlice, mailbox, filter: ['ALL'] } as GetMailsSettings;

  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  let emails: Mail[];
  try {
    emails = (await mailApi.getMails(auth, settings)) as Mail[];
  } catch (error) {
    return res
      .status(500)
      .json({ response: 'Error fetching emails: ' + error });
  }

  const unseenCount = emails.filter(
    (email) => !email.flags.some((flag) => flag.toLowerCase().includes('seen'))
  ).length;

  return res.status(200).json({
    unseenAmount: unseenCount,
    response: emails,
  });
}

export async function flagMail(req: Request, res: Response) {
  const messageId = req.params.id;
  const flags: string[] = req.body.flags;
  const addFlags: boolean = req.body.addFlags;

  if (!messageId || !flags || addFlags == null) {
    return res.status(403).json({ response: 'Invalid Params' });
  }
  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  try {
    await mailApi.flagMailById(auth, messageId, flags, addFlags);
  } catch (e: any) {
    return res.status(404).json({ response: e.message });
  }

  return res.status(200).json({
    response: true,
  });
}

export async function moveMail(req: Request, res: Response) {
  const messageId = req.params.id;
  const folder = req.body.folder as string;

  if (!messageId || !folder) {
    return res.status(403).json({ response: 'Invalid Params' });
  }

  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  try {
    await mailApi.moveMailToFolder(auth, messageId, folder);
  } catch (e: any) {
    return res.status(404).json({ response: e.message });
  }

  return res.status(200).json({
    response: true,
  });
}

export async function searchByText(req: Request, res: Response) {
  const { mailbox, filter } = req.query;
  const searchCriteria = ['ALL', ['TEXT', filter]];
  const settings = {
    mailbox,
    filter: searchCriteria,
    fetchSlice: '0:25',
  } as GetMailsSettings;

  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  let emails: Mail[];
  try {
    emails = (await mailApi.getMails(auth, settings)) as Mail[];
  } catch (error) {
    return res.status(500).json({ response: 'Error fetching emails:' + error });
  }

  return res.status(200).json({
    response: emails,
  });
}
