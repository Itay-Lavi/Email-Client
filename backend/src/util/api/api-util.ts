import Imap from 'node-imap';
import { MailAccount } from '../../models/mail_interfaces';

export function getImapConfig(auth: MailAccount): Imap {
  const mailServer = getMailServer(auth.hosting);

  return new Imap({
    user: auth.email,
    password: auth.password,
    host: mailServer.host,
    port: mailServer.port,
    tls: true,
  });
}

export const supportedHosts: string[] = ['outlook', 'yahoo', 'icloud', 'gmail'];

export function getMailServer(serverName: string, imap = true) {

  let host: string,
    port: number,
    secure = true,
    ciphers: string | null = null;

  if (imap) {
    port = 993;
    switch (serverName) {
      case supportedHosts[0]:
        host = 'outlook.office365.com';
        break;
      case supportedHosts[1]:
        host = 'imap.mail.yahoo.com';
        break;
      case supportedHosts[2]:
        host = 'imap.mail.me.com';
        break;
      default:
        host = 'imap.gmail.com';
    }
  } else {
    port = 465;
    switch (serverName) {
      case supportedHosts[0]:
        host = 'smtp-mail.outlook.com';
        port = 587;
        secure = false;
        ciphers = 'SSLv3';
        break;
        case supportedHosts[1]:
        host = 'smtp.mail.yahoo.com';
        break;
        case supportedHosts[2]:
        host = 'smtp.mail.me.com';
        port = 587;
        break;
      default:
        host = 'smtp.gmail.com';
        break;
    }
  }
  return { host, port, secure, ciphers };
}
