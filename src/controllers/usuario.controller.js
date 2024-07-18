import { pool } from "../database.js";
import ExcelJS from "exceljs";
import { formatDate } from "../lib/fechaHelper.js";

export const renderUsuarios = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_users");
  res.render("usuario/usuarioList", { datos: rows });
};

export const renderTableUsuarioPage = async (req, res) => {

  const { desde, hasta, name, lastname, email, mobile, provincia, ciudad, corralon, profesion, antiguedad } = req.body;

  console.log(req.body);
  let query = `SELECT name, lastname, email, mobile, provincia, ciudad, corralon, profesion, antiguedad, DATE_FORMAT(createdDtm, '%d-%m-%Y %H:%i:%s') as createdDtm
               FROM tbl_users
               WHERE 1=1`; // 'WHERE 1=1' es una forma común de simplificar la concatenación de condiciones

  const params = [];

  if (desde) {
    query += ' AND createdDtm >= ?';
    params.push(desde);
  }
  if (hasta) {
    query += ' AND createdDtm <= ?';
    params.push(hasta);
  }

  if (name) {
    query += ' AND name LIKE ?';
    params.push(`%${name}%`);
  }

  if (lastname) {
    query += ' AND lastname LIKE ?';
    params.push(`%${lastname}%`);
  }

  if (email) {
    query += ' AND email LIKE ?';
    params.push(`%${email}%`);
  }

  if (mobile) {
    query += ' AND mobile LIKE ?';
    params.push(`%${mobile}%`);
  }

  if (provincia) {
    query += ' AND provincia LIKE ?';
    params.push(`%${provincia}%`);
  }

  if (ciudad) {
    query += ' AND ciudad LIKE ?';
    params.push(`%${ciudad}%`);
  }

  if (corralon) {
    query += ' AND corralon LIKE ?';
    params.push(`%${corralon}%`);
  }

  if (profesion) {
    query += ' AND profesion LIKE ?';
    params.push(`%${profesion}%`);
  }

  if (antiguedad) {
    query += ' AND antiguedad = ?';
    params.push(antiguedad);
  }

  console.log(query, params);
  const [rows] = await pool.query(query, params);

  res.render('usuario/usuarioTable', { datos: rows, filtros: req.body });
};

export const deleteUsuario = async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM tbl_users WHERE userid = ?", [id]);
  await req.setFlash("success", `usuario ${id} Removed Successfully`);
  return res.redirect("usuario/usuarioList");
};

export const renderTableUsuarioGestion = async (req, res) => {
  const [rows] = await pool.query("SELECT userid, name, lastname, email, mobile, provincia, ciudad, corralon, profesion, antiguedad, DATE_FORMAT(createdDtm, '%d-%m-%Y %H:%i:%s') as createdDtm from tbl_users");
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
  const [result] = await pool.query("SELECT * FROM tbl_users WHERE userid = ?", [
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

export const exportUsuario = async (req, res) => {
  
  const { nombre, url, video, categoria } = req.body;

  let query = `SELECT name, lastname, email, mobile, provincia, ciudad, corralon, profesion, antiguedad, DATE_FORMAT(createdDtm, '%d-%m-%Y %H:%i:%s') as createdDtm
    FROM tbl_users`;

  let params = [];

  if (nombre) {
    query += ' AND te.nombre LIKE ?';
    params.push(`%${nombre}%`);
  }

  const [rows] = await pool.query(query, params);

  const workbook = new ExcelJS.Workbook();
  const worksheet = workbook.addWorksheet("Usuario");

  // Agrega los encabezados
  const headers = Object.keys(rows[0]);
  worksheet.addRow(headers);

  // Aplica estilo a los encabezados
  worksheet.getRow(1).eachCell((cell) => {
    cell.font = { bold: true };
    cell.alignment = { vertical: "middle", horizontal: "center" };
    cell.fill = {
      type: "pattern",
      pattern: "solid",
      fgColor: { argb: "FFFFCC00" },
    };
  });

  // Agrega las filas de datos
  rows.forEach((row) => {
    worksheet.addRow(Object.values(row));
  });

  // Ajusta automáticamente el ancho de las columnas según el contenido
  worksheet.columns.forEach((column) => {
    let maxLength = 0;
    column.eachCell({ includeEmpty: true }, (cell) => {
      const columnLength = cell.value ? cell.value.toString().length : 10;
      if (columnLength > maxLength) {
        maxLength = columnLength;
      }
    });
    column.width = maxLength < 10 ? 10 : maxLength;
  });

  // Configura la respuesta para descargar el archivo
  res.setHeader("Content-Disposition", 'attachment; filename="Usuarios.xlsx"');
  res.setHeader(
    "Content-Type",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  );

  await workbook.xlsx.write(res);
  res.end();
};
