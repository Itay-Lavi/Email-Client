import { NextFunction, Request, Response } from 'express';
import zlip from 'node:zlib';

export function compress(req: Request, res: Response, next: NextFunction) {
  const originalSend = res.send;

  res.send = function (data: any) {
    let buffer: Buffer;
    try {
      buffer = zlip.gzipSync(JSON.stringify(data));
    } catch (err) {
      return originalSend.apply(res);
    }
    const base64 = buffer!.toString('base64');
    return originalSend.call(this, base64);
  };

  next();
}

export function deCompress(req: Request, res: Response, next: NextFunction) {
  if (req.body == null) {
   return next();
  }
  
  let jsonParsed: string;
  try {
    const buffer = Buffer.from(req.body, 'base64');
    const decompressedData = zlip.gunzipSync(buffer).toString('utf8');
    jsonParsed = JSON.parse(decompressedData);
  } catch (err) {
    return next();
  }

  req.body = jsonParsed!;

  next();
}
