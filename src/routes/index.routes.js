import { Router } from "express";

import {
  renderAboutPage,
  renderIndexPage,
  renderNewEntryPage,
  createNewEntry,
  renderTablePage,
  renderLinks,
  deleteBook,
} from "../controllers/index.controller.js";

const router = Router();

router.get("/", renderIndexPage);

router.get("/about", renderAboutPage);

router.get("/new-entry", renderNewEntryPage);

router.post("/new-entry", createNewEntry);
/* 
router.get("/delete/:id", deleteBook);

router.get("/table", renderTablePage);

router.get("/list", renderLinks);
 */

export default router;
