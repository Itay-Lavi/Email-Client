import { sign, verify } from 'jsonwebtoken';

import config from '../config';
import { MailAccount } from '../models/mail_interfaces';

const KEY = config.jwt.key;

export function createJSONToken(account: MailAccount) {
  return sign(account, KEY);
}

export function validateJSONToken(token: string) {
  return verify(token, KEY);
}
