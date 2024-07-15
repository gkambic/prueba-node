import { pool } from "../database.js";

export const renderExamenes = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_examenes");
  res.render("examen/examenList", { datos: rows });
};

export const renderTableExamenPage = async (req, res) => {
  const { nombre, url, video, categoria } = req.body;

    let query = `
    SELECT te.id, te.nombre, te.url, tv.titulo AS video, tc.nombre AS categoria
    FROM tbl_examenes te
    LEFT JOIN tbl_videos tv ON te.id_video = tv.id
    LEFT JOIN tbl_categorias tc ON te.categoria_id = tc.id`;
    let params = [];

    if (nombre) {
      query += ' AND te.nombre LIKE ?';
      params.push(`%${nombre}%`);
    }
    if (url) {
      query += ' AND te.url LIKE ?';
      params.push(`%${url}%`);
    }
    if (categoria) {
      query += ' AND tc.nombre = ?';
      params.push(categoria);
    }
    if (video) {
      query += ' AND tv.titulo = ?';
      params.push(video);
    }

    const [rows] = await pool.query(query, params);

    res.render('examen/examenTable', { datos: rows , filtros: req.body });
};

export const renderTableExamenGestion = async (req, res) => {
  const [rows] = await pool.query(`
    SELECT te.id, te.nombre, te.url, tv.titulo AS video, tc.nombre AS categoria
    FROM tbl_examenes te
    LEFT JOIN tbl_videos tv ON te.id_video = tv.id
    LEFT JOIN tbl_categorias tc ON te.categoria_id = tc.id
  `);
  res.render("examen/examenGestion", { datos: rows });
};

export const deleteExamen = async (req, res) => {
  const { id } = req.params;
  console.log("Este es el id a borrar", id);
  await pool.query("DELETE FROM tbl_examenes WHERE ID = ?", [id]);
  await req.setFlash("success", `examen ${id} Removed Successfully`);
  return res.redirect("/examenGestion");
};

export const renderCreateExamenPage = async (req, res) => {
  const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
  const [videos] = await pool.query("SELECT * FROM tbl_videos");
  res.render("examen/ExamenCreate", {
    optionsCategory: categorias,
    optionVideos: videos,
  });
};

export const createExamen = async (req, res) => {
  const { nombre, url, categoria_id, video_id } = req.body;
  console.log(req.body);
    
  // Usar null en lugar de valores vacíos
    const categoriaId = categoria_id ? categoria_id : null;
    const videoId = video_id ? video_id : null;

  await pool.query(
    "INSERT INTO tbl_examenes (nombre, url, categoria_id, id_video) VALUES (?, ?, ?, ?)",
    [nombre, url, categoriaId, videoId]
  );
  await req.setFlash("success", "examen Added Successfully");
  return res.redirect("/examenGestion");
};

export const editExamen = async (req, res) => {
  const { id, nombre, url, categoria_id, video_id } = req.body;
  console.log("Este es el id", id);
  await pool.query(
    "UPDATE tbl_examenes SET nombre = ?, url = ?, categoria_id = ?, id_video = ? WHERE id = ?",
    [nombre, url, categoria_id, video_id, id]
  );
  await req.setFlash("success", "examen Added Successfully");
  return res.redirect("/examenGestion");
};

export const renderEditExamen = async (req, res) => {
  const { id } = req.params;
  const [result] = await pool.query("SELECT * FROM tbl_examenes WHERE id = ?", [
    id,
  ]);
  const datos = result[0];

  // Consulta para obtener las opciones de categoría y videos
  const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
  const [videos] = await pool.query("SELECT * FROM tbl_videos");

  res.render("examen/ExamenEdit", {
    datos,
    optionsCategory: categorias,
    optionVideos: videos,
  });
};
