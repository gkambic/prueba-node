import { Router } from "express";

import {
    renderCupones,
    renderTableCuponPage,
    deleteCupon
} from "../controllers/cupon.controller.js";

const router = Router();


router.get("/delete/:id", deleteCupon);

router.get("/cuponTable", renderTableCuponPage);

router.get("/cuponList", renderCupones);


export default router;
