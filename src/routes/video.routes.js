import { Router } from "express";

import {
    renderVideos,
    renderTableVideoPage,
    deleteVideo,
    renderTableVideoGestion,
    renderCreateVideoPage,
    createVideo,
    renderEditVideo,
    editVideo,
    exportVideo
} from "../controllers/video.controller.js";
import { isLoggedIn } from "../middlewares/protectedRoutes.js";

const router = Router();


router.get("/deleteVideo/:id", isLoggedIn, deleteVideo);

router.get("/videoTable",isLoggedIn, renderTableVideoPage);

router.post("/videoTable", isLoggedIn, renderTableVideoPage);

router.get("/videoGestion", isLoggedIn, renderTableVideoGestion);

router.get("/videoList", isLoggedIn, renderVideos);

router.get("/createVideo", isLoggedIn, renderCreateVideoPage);

router.post("/createVideo", isLoggedIn, createVideo);

router.get("/editVideo/:id", isLoggedIn, renderEditVideo);

router.post("/editVideo", isLoggedIn, editVideo)

router.post("/exportVideo", isLoggedIn, exportVideo);

export default router;
