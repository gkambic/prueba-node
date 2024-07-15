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
  res.render("usuario/usuarioTable", { datos: rows , filtros: req.body });
};

export const deleteUsuario = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_users WHERE ID = ?", [id]);
    await req.setFlash("success", `usuario ${id} Removed Successfully`);
    return res.redirect("usuario/usuarioList");
  };

  
  export const renderTableUsuarioGestion = async (req, res) => {
    const [rows] = await pool.query(
      "SELECT * FROM tbl_users"
    );
    res.render("usuario/usuarioGestion", { datos: rows });
  };

  export const renderCreateUsuarioPage = async (req, res) => {
    const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
    const [videos] = await pool.query("SELECT * FROM tbl_videos");
    res.render("usuario/UsuarioCreate", {
      optionsCategory: categorias,
      optionVideos: videos,
    });
  };
  
  export const createUsuario = async (req, res) => {
    const { nombre, url, categoria_id, video_id } = req.body;
    console.log(req.body);
    await pool.query(
      "INSERT INTO tbl_users (nombre, url, categoria_id, id_video) VALUES (?, ?, ?, ?)",
      [nombre, url, categoria_id, video_id]
    );
    await req.setFlash("success", "usuario Added Successfully");
    return res.redirect("/usuarioTable");
  };

  export const editUsuario = async (req, res) => {
    const { id, nombre, url, categoria_id, video_id } = req.body;
    console.log("Este es el id", id);
    await pool.query(
      "UPDATE tbl_users SET nombre = ?, url = ?, categoria_id = ?, id_video = ? WHERE id = ?",
      [nombre, url, categoria_id, video_id, id]
    );
    await req.setFlash("success", "usuario Added Successfully");
    return res.redirect("/usuarioTable");
  };
  
  export const renderEditUsuario = async (req, res) => {
    const { id } = req.params;
    const [result] = await pool.query("SELECT * FROM tbl_users WHERE id = ?", [
      id,
    ]);
    const datos = result[0];
  
    // Consulta para obtener las opciones de categoría y videos
    const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
    const [videos] = await pool.query("SELECT * FROM tbl_videos");
  
    res.render("usuario/UsuarioEdit", {
      datos,
      optionsCategory: categorias,
      optionVideos: videos,
    });
  };