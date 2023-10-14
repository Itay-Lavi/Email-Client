import { NextFunction, Request, Response } from 'express';
import { validateJSONToken } from '../util/jwt';

function return401(res: Response, message?: string) {
  return res
    .status(401)
    .json({ success: false, message: message ?? '401 Unauthorized' });
}

export function checkAuth(req: Request, res: Response, next: NextFunction) {
  if (!req.headers.authorization) return return401(res);

  const authToken = req.headers.authorization;
  let validatedToken;
  try {
    validatedToken = validateJSONToken(authToken) as {
      email: number;
      password: number;
      hosting: number;
    };
    res.locals.email = validatedToken.email;
    res.locals.password = validatedToken.password;
    res.locals.hosting = validatedToken.hosting;
    if (!validatedToken.email || !validatedToken.password || !validatedToken.hosting) throw '';
  } catch (error) {
    return return401(res);
  }
  next();
}
