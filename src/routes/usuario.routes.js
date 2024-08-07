import { Router } from "express";
import passport from "passport";
//import { pool } from "../database.js";

import {
    renderUsuarios,
    renderTableUsuarioPage,
    deleteUsuario,
    renderTableUsuarioGestion,
    renderCreateUsuarioPage,
    createUsuario,
    renderEditUsuario,
    editUsuario,
    exportUsuario,
    renderTableUsuarioAdminPage
} from "../controllers/usuario.controller.js";
import { encryptPassword } from "../lib/helpers.js";
import { isLoggedIn } from "../middlewares/protectedRoutes.js";

const router = Router();


router.get("/deleteUsuario/:id",isLoggedIn, deleteUsuario);

router.get("/usuarioTable",isLoggedIn, renderTableUsuarioPage);

router.get("/adminTable",isLoggedIn, renderTableUsuarioAdminPage);

router.post("/usuarioTable",isLoggedIn, renderTableUsuarioPage);

router.get("/usuarioGestion",isLoggedIn, renderTableUsuarioGestion);

router.get("/usuarioList",isLoggedIn, renderUsuarios);

router.get("/createUsuario",isLoggedIn, renderCreateUsuarioPage);

router.post("/createUsuario",isLoggedIn, createUsuario);

router.get("/editUsuario/:id",isLoggedIn, renderEditUsuario);

router.post("/editUsuario",isLoggedIn, editUsuario)

router.post("/exportUsuario",isLoggedIn, exportUsuario);

export default router;
