import cors from 'cors';
import express from 'express';

import mailRoutes from './routes/mail_routes';
import folderRoutes from './routes/folder_routes';
import authRoutes from './routes/auth_routes';
import config from './config';
import { checkAuth } from './middlewares/auth-middleware';
import { compress, deCompress } from './middlewares/compress-middleware';

const app = express();

app.use(express.text({limit: '20mb'}))

app.use(cors());

app.use(compress);
app.use(deCompress);

app.use('/auth', authRoutes);
app.use(checkAuth);
app.use('/mail', mailRoutes);
app.use('/folder', folderRoutes);

app.listen(config.port, () => console.log(`Server started successfully! \n Port ${config.port}`));
