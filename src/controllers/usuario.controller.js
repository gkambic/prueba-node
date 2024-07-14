import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderUsuarios = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_users");
  res.render("usuario/usuarioList", { datos: rows });
};

export const renderTableUsuarioPage = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_users");
  res.render("usuario/usuarioTable", { datos: rows });
};

export const deleteUsuario = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_users WHERE ID = ?", [id]);
    await req.setFlash("success", `usuario ${id} Removed Successfully`);
    return res.redirect("usuario/usuarioList");
  };
