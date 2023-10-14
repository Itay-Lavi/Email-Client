import { Request, Response } from 'express';
import { createJSONToken } from '../util/jwt';
import { validateMailAccount } from '../util/validation';
import { supportedHosts } from '../util/api/api-util';
import { authIsServerValidated } from '../util/api/auth';
import { MailAccount } from '../models/mail_interfaces';


export function getAccountAuth(req: Request, res: Response) {
  return res.status(200).json({
    response: { email: res.locals.email, hosting: res.locals.hosting },
  });
}

export async function getSupportedHosts(req: Request, res: Response) {
  return res.status(200).json({ response: supportedHosts });
}

export async function signin(req: Request, res: Response) {
  const { email, password, hosting } = req.headers;
  const account = { email, password, hosting } as MailAccount;
  if (!validateMailAccount(account)) {
    return res.status(403).json({
      response: 'Account data is missing or invalid!',
    });
  }

  let accountIsValidated: boolean = false;
  try {
    accountIsValidated=  await authIsServerValidated(account)
  } catch (_) {}

  if (!accountIsValidated) {
    return res.status(401).json({
      response: 'Account is unauthorized by the provider',
    });
  }

  const token = createJSONToken(account);
  return res.status(200).json({ response: token });
}
