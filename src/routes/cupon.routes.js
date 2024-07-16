import { Router } from "express";

import {
    renderCupones,
    renderTableCuponPage,
    deleteCupon,
    renderTableCuponGestion,
    renderCreateCuponPage,
    createCupon,
    renderEditCupon,
    editCupon,
    exportCupon
} from "../controllers/cupon.controller.js";

const router = Router();

router.get("/deleteCupon/:id", deleteCupon);

router.get("/cuponTable", renderTableCuponPage);

router.post("/cuponTable", renderTableCuponPage);

router.get("/cuponGestion", renderTableCuponGestion);

router.get("/cuponList", renderCupones);

router.get("/createCupon", renderCreateCuponPage);

router.post("/createCupon", createCupon);

router.get("/editCupon/:id", renderEditCupon);

router.post("/editCupon", editCupon);

router.post("/exportCupon", exportCupon);

export default router;
