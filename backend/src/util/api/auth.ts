import { MailAccount } from '../../models/mail_interfaces';
import { getImapConfig } from './api-util';

export function authIsServerValidated(auth: MailAccount) {
  return new Promise<boolean>((resolve, reject) => {
    const imap = getImapConfig(auth);
    imap.once('error', () => {
      reject(false);
    });

    imap.once('ready', () => {
        resolve(true);
    });
    imap.once('end', () => {});

    imap.connect();
  });
}
