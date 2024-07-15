import config from "../config.js";
import fs from "fs";
import { v4 } from "uuid";
import { pool } from "../database.js";


export const renderInsignias = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_insignias");
  res.render("insignia/insigniaList", { datos: rows });
};

export const renderTableInsigniaPage = async (req, res) => {
  const [rows] = await pool.query("select ti.id, ti.nombre, ti.descripcion, ti.imagen_url, te.nombre as examen from tbl_insignias ti LEFT JOIN tbl_examenes te on te.id = ti.examen_id ");
  res.render("insignia/insigniaTable", { datos: rows , filtros: req.body });
};

export const deleteInsignia = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_insignias WHERE ID = ?", [id]);
    await req.setFlash("success", `Insignia ${id} Removed Successfully`);
    return res.redirect("/insigniaGestion");
  };

  
  export const renderTableInsigniaGestion = async (req, res) => {
    const [rows] = await pool.query(
      "select ti.id, ti.nombre, ti.descripcion, ti.imagen_url, te.nombre as examen from tbl_insignias ti LEFT JOIN tbl_examenes te on te.id = ti.examen_id "
    );
    res.render("insignia/insigniaGestion", { datos: rows });
  };

  export const renderCreateInsigniaPage = async (req, res) => {
    const [examanes] = await pool.query("SELECT * FROM tbl_examenes");
    res.render("insignia/InsigniaCreate", {
      optionExamenes: examanes,
    });
  };
  
  export const createInsignia = async (req, res) => {
    const { nombre, descripcion, imagen, examen_id } = req.body;
    
    // Usar null en lugar de valores vacíos
    const examenId = examen_id ? examen_id : null;
    
    await pool.query(
      "INSERT INTO tbl_insignias (nombre, descripcion, imagen_url, examen_id) VALUES (?, ?, ?, ?)",
      [nombre, descripcion, imagen, examenId]
    );
    await req.setFlash("success", "insignia Added Successfully");
    return res.redirect("/insigniaGestion");
  };

  export const editInsignia = async (req, res) => {
    const { id, nombre, descripcion, imagen, examen_id } = req.body;
    console.log(req.body);
    const examenId = examen_id ? examen_id : null;

    await pool.query(
      "UPDATE tbl_insignias SET nombre = ?, descripcion = ?, imagen_url = ?, examen_id = ? WHERE id = ?",
      [nombre, descripcion, imagen, examenId, id]
    );
    await req.setFlash("success", "insignia Added Successfully");
    return res.redirect("/insigniaGestion");
  };
  
  export const renderEditInsignia = async (req, res) => {
    const { id } = req.params;
    const [result] = await pool.query("SELECT * FROM tbl_insignias WHERE id = ?", [
      id,
    ]);
    const datos = result[0];
  
    // Consulta para obtener las opciones de categoría y videos
    const [examanes] = await pool.query("SELECT * FROM tbl_examenes");
    res.render("insignia/InsigniaEdit", {
      datos,
      optionExamenes: examanes,
    });
  };