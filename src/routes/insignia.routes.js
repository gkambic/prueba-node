import { Router } from "express";

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

const router = Router();


router.get("/deleteInsignia/:id", deleteInsignia);

router.get("/insigniaTable", renderTableInsigniaPage);

router.post("/insigniaTable", renderTableInsigniaPage);

router.get("/insigniaGestion", renderTableInsigniaGestion);

router.get("/insigniaList", renderInsignias);

router.get("/createInsignia", renderCreateInsigniaPage);

router.post("/createInsignia", createInsignia);

router.get("/editInsignia/:id", renderEditInsignia);

router.post("/editInsignia", editInsignia)

router.post("/exportInsignia", exportInsignia);

export default router;
