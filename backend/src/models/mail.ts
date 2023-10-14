

export class Mail {
  constructor(
    public id: string,
    public from: any,
    public to: any,
    public subject: string,
    public html: string,
    public timestamp: Date,
    public flags: String[],
    public attachments?: {
      contentType: Buffer;
      bytesSize: number;
      fileName: string;
    }[]
  ) {}

  static fromMap(parsed: any, flags: String[], includeAttactment: boolean): Mail {
    return new Mail(
      parsed.messageId || '',
      parsed.from,
      parsed.to,
      parsed.subject || '',
      parsed.html || '',
      parsed.date as Date,
      flags,
      includeAttactment ? parsed?.attachments : null as any
    );
  }
}
