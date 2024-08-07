import { Router } from "express";

import {
    renderExamenes,
    renderTableExamenPage,
    deleteExamen,
    renderCreateExamenPage,
    createExamen,
    renderEditExamen,
    editExamen,
    renderTableExamenGestion,
    exportExamen
} from "../controllers/examen.controller.js";
import { isLoggedIn } from "../middlewares/protectedRoutes.js";

const router = Router();


router.get("/deleteExamen/:id",isLoggedIn, deleteExamen);

router.post("/examenTable",isLoggedIn, renderTableExamenPage);

router.get("/examenTable",isLoggedIn, renderTableExamenPage);

router.get("/examenGestion",isLoggedIn, renderTableExamenGestion);

router.get("/examenList",isLoggedIn, renderExamenes);

router.get("/createExamen",isLoggedIn, renderCreateExamenPage);

router.post("/createExamen",isLoggedIn, createExamen);

router.get("/editExamen/:id",isLoggedIn, renderEditExamen);

router.post("/editExamen",isLoggedIn, editExamen);

router.post("/exportExamen",isLoggedIn, exportExamen);

export default router;
