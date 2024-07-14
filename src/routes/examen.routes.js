import { Router } from "express";

import {
    renderExamenes,
    renderTableExamenPage,
    deleteExamen
} from "../controllers/examen.controller.js";

const router = Router();


router.get("/delete/:id", deleteExamen);

router.get("/examenTable", renderTableExamenPage);

router.get("/examenList", renderExamenes);


export default router;
