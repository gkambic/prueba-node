/* import { Router } from "express";

import {
    renderInsignias,
    renderTableInsigniaPage,
    deleteInsignia,
    renderTableInsigniaGestion,
    renderCreateInsigniaPage,
    createInsignia,
    renderEditInsignia,
    editInsignia,
    exportInsignia
} from "../controllers/insignia.controller.js";
import { isLoggedIn } from "../middlewares/protectedRoutes.js";

const router = Router();


router.get("/deleteInsignia/:id",isLoggedIn, deleteInsignia);

router.get("/insigniaTable",isLoggedIn, renderTableInsigniaPage);

router.post("/insigniaTable",isLoggedIn, renderTableInsigniaPage);

router.get("/insigniaGestion",isLoggedIn, renderTableInsigniaGestion);

router.get("/insigniaList",isLoggedIn, renderInsignias);

router.get("/createInsignia",isLoggedIn, renderCreateInsigniaPage);

router.post("/createInsignia",isLoggedIn, createInsignia);

router.get("/editInsignia/:id",isLoggedIn, renderEditInsignia);

router.post("/editInsignia",isLoggedIn, editInsignia)

router.post("/exportInsignia",isLoggedIn, exportInsignia);

export default router;
 */