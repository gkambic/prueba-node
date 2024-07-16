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

const router = Router();


router.get("/deleteVideo/:id", deleteVideo);

router.get("/videoTable", renderTableVideoPage);

router.post("/videoTable", renderTableVideoPage);

router.get("/videoGestion", renderTableVideoGestion);

router.get("/videoList", renderVideos);

router.get("/createVideo", renderCreateVideoPage);

router.post("/createVideo", createVideo);

router.get("/editVideo/:id", renderEditVideo);

router.post("/editVideo", editVideo)

router.post("/exportVideo", exportVideo);

export default router;
