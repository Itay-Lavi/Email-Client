import { MailAccount } from "../models/mail_interfaces";

export function isValidEmail(email: string): boolean {
    // Regular expression to validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }
  
 export function validateMailAccount(account: MailAccount): boolean {
    if (!isValidEmail(account.email)) {
      console.error("Invalid email format.");
      return false;
    }
  
    if (!account.hosting || !account.password) {
        return false;
    }
  
    return true;
  }