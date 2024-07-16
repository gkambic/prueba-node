import { Router } from "express";

import {
    renderUsuarios,
    renderTableUsuarioPage,
    deleteUsuario,
    renderTableUsuarioGestion,
    renderCreateUsuarioPage,
    createUsuario,
    renderEditUsuario,
    editUsuario,
    exportUsuario
} from "../controllers/usuario.controller.js";

const router = Router();


router.get("/deleteUsuario/:id", deleteUsuario);

router.get("/usuarioTable", renderTableUsuarioPage);

router.post("/usuarioTable", renderTableUsuarioPage);

router.get("/usuarioGestion", renderTableUsuarioGestion);

router.get("/usuarioList", renderUsuarios);

router.get("/createUsuario", renderCreateUsuarioPage);

router.post("/createUsuario", createUsuario);

router.get("/editUsuario/:id", renderEditUsuario);

router.post("/editUsuario", editUsuario)

router.post("/exportUsuario", exportUsuario);

export default router;
