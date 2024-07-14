import { Router } from "express";
import auth from "./auth.routes.js";
import index from "./index.routes.js";
import videos from "./video.routes.js";

import cupones from "./cupon.routes.js";
import examenes from "./examen.routes.js";
import insignias from "./insignia.routes.js";
import usuario from "./usuario.routes.js";

const router = Router();

router.use(index);
router.use(auth);
router.use(videos);

router.use(cupones);
router.use(examenes);
router.use(insignias);
router.use(usuario);


export default router;
