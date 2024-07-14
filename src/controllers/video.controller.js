import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderVideos = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_videos");
  res.render("video/videoList", { datos: rows });
};

export const renderTableVideoPage = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_videos");
  res.render("video/videoTable", { datos: rows });
};

export const deleteVideo = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_videos WHERE ID = ?", [id]);
    await req.setFlash("success", `Video ${id} Removed Successfully`);
    return res.redirect("video/videoList");
  };
