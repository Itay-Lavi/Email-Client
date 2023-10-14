import { Response } from 'express';
import smtpClient from '../util/api/folder';
import { MailAccount } from '../models/mail_interfaces';

export async function getFolders(req: any, res: Response) {
  const auth = {
    email: res.locals.email,
    password: res.locals.password,
    hosting: res.locals.hosting,
  } as MailAccount;

  let folders;
  try {
    folders = await smtpClient.getFolders(auth);
  } catch (e) {
    return res.status(500).json({ response: e });
  }

  await new Promise(resolve => setTimeout(resolve, 3000));
  res.status(200).json({ response: folders });
}

