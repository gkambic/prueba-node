import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderExamenes = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_examenes");
  res.render("examen/examenList", { datos: rows });
};

export const renderTableExamenPage = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_examenes");
  res.render("examen/examenTable", { datos: rows });
};

export const deleteExamen = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_examenes WHERE ID = ?", [id]);
    await req.setFlash("success", `examen ${id} Removed Successfully`);
    return res.redirect("examen/examenList");
  };
