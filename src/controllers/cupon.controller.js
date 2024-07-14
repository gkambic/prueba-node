import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderCupones = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_cupones");
  res.render("cupon/cuponList", { datos: rows });
};

export const renderTableCuponPage = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_cupones");
  res.render("cupon/cuponTable", { datos: rows });
};

export const deleteCupon = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_cupones WHERE ID = ?", [id]);
    await req.setFlash("success", `Cupon ${id} Removed Successfully`);
    return res.redirect("cupon/cuponList");
  };
