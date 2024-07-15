import { Router } from "express";

import {
    renderExamenes,
    renderTableExamenPage,
    deleteExamen,
    renderCreateExamenPage,
    createExamen,
    renderEditExamen,
    editExamen,
    renderTableExamenGestion
} from "../controllers/examen.controller.js";

const router = Router();


router.get("/deleteExamen/:id", deleteExamen);

router.post("/examenTable", renderTableExamenPage);

router.get("/examenTable", renderTableExamenPage);

router.get("/examenGestion", renderTableExamenGestion);

router.get("/examenList", renderExamenes);

router.get("/createExamen", renderCreateExamenPage);

router.post("/createExamen", createExamen);

router.get("/editExamen/:id", renderEditExamen);

router.post("/editExamen", editExamen)

export default router;
