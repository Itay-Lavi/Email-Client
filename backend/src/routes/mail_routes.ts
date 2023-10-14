import { Router } from "express";
import {  flagMail, searchByText, getMails, moveMail, sendMail } from "../controllers/mail_controller";

const router = Router();

router.get('/', getMails);

router.get('/filter', searchByText);

router.patch('/flag/:id', flagMail);

router.put('/move/:id', moveMail);

router.post('/', sendMail);

export default router;