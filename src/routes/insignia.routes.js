import { Router } from "express";

import {
    renderInsignias,
    renderTableInsigniaPage,
    deleteInsignia
} from "../controllers/insignia.controller.js";

const router = Router();


router.get("/delete/:id", deleteInsignia);

router.get("/insigniaTable", renderTableInsigniaPage);

router.get("/insigniaList", renderInsignias);


export default router;
