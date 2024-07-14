import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderInsignias = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_insignias");
  res.render("insignia/insigniaList", { datos: rows });
};

export const renderTableInsigniaPage = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_insignias");
  res.render("insignia/insigniaTable", { datos: rows });
};

export const deleteInsignia = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_insignias WHERE ID = ?", [id]);
    await req.setFlash("success", `Insignia ${id} Removed Successfully`);
    return res.redirect("insignia/insigniaList");
  };
