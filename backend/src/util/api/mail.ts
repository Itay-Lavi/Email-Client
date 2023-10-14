import nodemailer from 'nodemailer';
import Imap from 'node-imap';
import { ParsedMail, simpleParser } from 'mailparser';
import { getImapConfig, getMailServer } from './api-util';
import { Mail } from '../../models/mail';
import { GetMailsSettings, MailAccount, MailRequest } from '../../models/mail_interfaces';


async function sendMail(mailReq: MailRequest) {
  const mailServer = getMailServer(mailReq.auth.hosting, false);

  const transporter = nodemailer.createTransport({
    host: mailServer.host,
    port: mailServer.port,
    secure: mailServer.secure,
    auth: {
      user: mailReq.auth.email,
      pass: mailReq.auth.password,
    },
    tls: {
      ciphers: mailServer.ciphers ?? '',
    },
    replyTo: ''
  });

  const info = await transporter.sendMail({
    from: mailReq.auth.email,
    to: mailReq.mail.to,
    subject: mailReq.mail.subject,
    html: mailReq.mail.html,
  });
  return info;
}

function getMails(auth: MailAccount, settings: GetMailsSettings) {
  const imap = getImapConfig(auth) as Imap;

  return new Promise((resolve, reject) => {
    imap.once('ready', () => {
      imap.openBox(settings.mailbox, true, (error, box) => {
        if (error) {
          return reject(new Error('Error opening the box : ' + error.message));
        }

        const fetchOptions = { bodies: '', markSeen: false };

        imap.search(settings.filter, async (searchError, results) => {
          if (searchError) {
            return reject(new Error('Search Error: ' + searchError.message));
          } else if (results.length === 0) {
            return resolve([]);
          }

          let sortedResults = results.sort((a, b) => b - a);

          sortedResults = sortedResults.slice(
            +settings.fetchSlice.split(':')[0],
            +settings.fetchSlice.split(':')[1]
          );

          let fetch: Imap.ImapFetch | null;
          try {
            fetch = imap.fetch(sortedResults, fetchOptions);
          } catch (_) {
            return resolve([]);
          }
          const emails: Mail[] = [];

          fetch.on('message', async (message, sequenceNumber) => {
            const messageData: any = [];
            message.on('body', (stream, info) => {
              let buffer = '';
              stream.on('data', (chunk) => {
                messageData.push(chunk);
                buffer += chunk.toString('utf8');
              });
              stream.once('end', async () => {
                const mergedBuffer = Buffer.concat(messageData);
                const flags: string[] = await new Promise((resolve, reject) =>
                  message.on('attributes', (attributes) => {
                    return resolve(attributes.flags);
                  })
                );
                try {
                  const parsed: ParsedMail = await new Promise(
                    (resolve, reject) => {
                      simpleParser(mergedBuffer, (parseError, parsed) => {
                        if (parseError) {
                          console.error('Error parsing email:', parseError);
                          reject(parseError);
                        }
                        resolve(parsed);
                      });
                    }
                  );
                  const mail = Mail.fromMap(parsed, flags, false);
                  emails.push(mail);
                  if (emails.length === sortedResults.length) {
                    resolve(emails);
                    imap.end();
                  }
                } catch (error) {
                  reject(error);
                }
              });
            });
          });
          fetch.once('error', (fetchError) => {
            reject(fetchError);
          });
        });
      });
    });
    imap.once('error', (connectionError) => {
      reject(connectionError);
    });
    imap.connect();
  });
}

function flagMailById(
  auth: MailAccount,
  messageId: string,
  flags: string[],
  addFlags: boolean
) {
  return new Promise<void>((resolve, reject) => {
    const imap = getImapConfig(auth);

    imap.once('ready', () => {
      imap.openBox('INBOX', false, () => {
        const criteria = ['HEADER', 'message-id', messageId];

        imap.search([criteria], (err, results) => {
          if (err || results.length === 0) {
            imap.end(); // Close the connection if no email is found
            reject(new Error('No email found for this ID'));
            return;
          }
          if (addFlags) imap.addFlags(results, flags, afterAction());
          if (!addFlags) imap.delFlags(results, flags, afterAction());

          function afterAction(): (error: Error) => void {
            return (err) => {
              imap.end();
              if (err) {
                return reject(err);
              }
              imap.end();
              resolve();
            };
          }
        });
      });
    });

    imap.once('error', (err) => reject(err));
    imap.once('close', () =>
      reject(new Error('Connection closed unexpectedly'))
    );

    imap.connect();
  });
}

function moveMailToFolder(
  auth: MailAccount,
  messageId: string,
  folderName: string
) {
  return new Promise<void>((resolve, reject) => {
    const imap = getImapConfig(auth);

    imap.once('ready', () => {
      imap.openBox('INBOX', false, () => {
        const criteria = ['HEADER', 'message-id', messageId];

        imap.search([criteria], (err, results) => {
          if (err || results.length === 0) {
            imap.end();
            reject(new Error('No email found for this ID'));
            return;
          }
          imap.move(results, folderName, function (err) {
            if (err) {
              return reject(
                new Error(
                  `Error moving email to ${folderName}.  ${err.message}`
                )
              );
            }

            imap.end();
            resolve();
          });
        });
      });
    });

    // Error handling
    imap.once('error', (err) => reject(new Error(err)));
    imap.once('close', () =>
      reject(new Error('Connection closed unexpectedly'))
    );

    imap.connect();
  });
}


export default {
  sendMail,
  getMails,
  flagMailById,
  moveMailToFolder,
};
