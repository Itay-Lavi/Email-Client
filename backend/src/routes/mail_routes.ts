import { Router } from "express";
import {  flagMail, searchByText, getMails, moveMail, sendMail } from "../controllers/mail_controller";

const router = Router();

router.get('/', getMails);

router.get('/filter', searchByText);

router.patch('/flag', flagMail);

router.put('/move', moveMail);

router.post('/', sendMail);

export default router;