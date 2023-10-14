import { Router } from 'express';
import { getAccountAuth, getSupportedHosts, signin } from '../controllers/auth_controller';
import { checkAuth } from '../middlewares/auth-middleware';

const router = Router();

router.get('/', checkAuth, getAccountAuth);

router.get('/hosts', getSupportedHosts);

router.post('/', signin);


export default router;
