import { Router } from "express";
import { getFolders } from "../controllers/folder_controller";

const router = Router();

router.get('/', getFolders);

export default router;