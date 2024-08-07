import { Router } from "express";
import {
  renderSignIn,
  signIn,
  logout,
} from "../controllers/auth.controller.js";
import { isLoggedIn, isNotLoggedIn } from "../middlewares/protectedRoutes.js";
import { validator } from "../middlewares/validator.middleware.js";
import { signinSchema } from "../schemas/auth.schema.js";

const router = Router();

// SINGIN
router.get("/signin",isNotLoggedIn, renderSignIn);
router.post("/signin",isNotLoggedIn, signIn);

router.get("/logout", isLoggedIn, logout);

export default router;
