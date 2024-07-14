import { Router } from "express";

import {
    renderVideos,
    renderTableVideoPage,
    deleteVideo
} from "../controllers/video.controller.js";

const router = Router();


router.get("/delete/:id", deleteVideo);

router.get("/videoTable", renderTableVideoPage);

router.get("/videoList", renderVideos);


export default router;
