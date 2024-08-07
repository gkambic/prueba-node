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
    exportCupon,
    renderAsignarCupon,
    asignarCupon
} from "../controllers/cupon.controller.js";
import { isLoggedIn } from "../middlewares/protectedRoutes.js";

const router = Router();

router.get("/deleteCupon/:id",isLoggedIn, deleteCupon);

router.get("/cuponTable",isLoggedIn, renderTableCuponPage);

router.post("/cuponTable",isLoggedIn, renderTableCuponPage);

router.get("/cuponGestion",isLoggedIn, renderTableCuponGestion);

router.get("/cuponList",isLoggedIn, renderCupones);

router.get("/createCupon",isLoggedIn, renderCreateCuponPage);

router.post("/createCupon",isLoggedIn, createCupon);

router.get("/editCupon/:id",isLoggedIn, renderEditCupon);

router.post("/editCupon",isLoggedIn, editCupon);

router.get("/asignarCupon/:id",isLoggedIn, renderAsignarCupon);

router.post("/asignarCupon",isLoggedIn, asignarCupon);

router.post("/exportCupon",isLoggedIn, exportCupon);

export default router;
