import Imap from 'node-imap';
import { getImapConfig } from './api-util';
import { MailAccount } from '../../models/mail_interfaces';

function getFolders(auth: MailAccount): Promise<any[]> {
  const imap = getImapConfig(auth) as Imap;

  return new Promise((resolve, reject) => {
    imap.once('ready', () => {
      imap.getBoxes((err, boxes) => {
        if (err) {
          reject(err);
        } else {
          const folders = imapNestedFolders(boxes);
           //console.log(boxes['[Gmail]']['children']);
          resolve(folders);
        }
      });
      imap.end();
    });
    imap.connect();
  });
  
  function imapNestedFolders(folders: any): any[] {
    const foldersArr: any[] = [];
  
    for (const key in folders) {
      let folder: any;

      if (folders[key].attribs.indexOf('\\HasChildren') > -1) {
        const children = imapNestedFolders(folders[key].children);
  
        folder = {
          name:  key,
          children: children,
          specialUseAttrib: folders[key].special_use_attrib
        };
      } else {
        folder = {
          name: key,
          children: null,
          specialUseAttrib: folders[key].special_use_attrib
        };
      }
      foldersArr.push(folder);
    }
    return foldersArr;
  }
}

export default {
  getFolders,
};
