import { Router } from "express";

import {
    renderUsuarios,
    renderTableUsuarioPage,
    deleteUsuario
} from "../controllers/usuario.controller.js";

const router = Router();


router.get("/delete/:id", deleteUsuario);

router.get("/usuarioTable", renderTableUsuarioPage);

router.get("/usuarioList", renderUsuarios);


export default router;
