import { Mail } from "./mail";

export interface MailAccount {
  email: string;
  password: string;
  hosting: string;
}

export interface GetMailsSettings {
  fetchSlice: string;
  mailbox: string;
  filter: any;
}

export interface MailRequest {
  auth: MailAccount;
  mail: Omit<Mail, 'seen' | 'timestamp' | 'from'>;
}
