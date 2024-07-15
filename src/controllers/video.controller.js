import { pool } from "../database.js";


export const renderVideos = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_videos");
  res.render("video/videoList", { datos: rows });
};

export const renderTableVideoPage = async (req, res) => {
  const {titulo, url, watch_id, descripcion, imagen, examen } = req.body;

  let query = `select tv.id, tv.titulo, tv.url, tv.watch_id, tv.descripcion, tv.imagen, te.nombre as examen 
  from tbl_videos tv LEFT JOIN tbl_examenes te on tv.examen_id = te.id
  WHERE 1=1`;

  let params = [];

    if (titulo) {
      query += ' AND tv.titulo LIKE ?';
      params.push(`%${titulo}%`);
    }

    if (url) {
      query += ' AND tv.url LIKE ?';
      params.push(`%${url}%`);
    }

    if (watch_id) {
      query += ' AND tv.watch_id LIKE ?';
      params.push(`%${watch_id}%`);
    }

    if (descripcion) {
      query += ' AND tv.descripcion LIKE ?';
      params.push(`%${descripcion}%`);
    }

    if (imagen) {
      query += ' AND tv.imagen LIKE ?';
      params.push(`%${imagen}%`);
    }

    if (examen) {
      query += ' AND te.nombre LIKE ?';
      params.push(`%${examen}%`);
    }

  const [rows] = await pool.query(query, params);
  res.render("video/videoTable", { datos: rows , filtros: req.body });
};

export const deleteVideo = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_videos WHERE ID = ?", [id]);
    await req.setFlash("success", `Video ${id} Removed Successfully`);
    return res.redirect("/videoGestion");
  };

  
  export const renderTableVideoGestion = async (req, res) => {
    const [rows] = await pool.query(
      "select tv.id, tv.titulo, tv.url, tv.watch_id, tv.descripcion, tv.imagen, te.nombre as examen from tbl_videos tv LEFT JOIN tbl_examenes te on tv.examen_id = te.id"
    );
    res.render("video/videoGestion", { datos: rows });
  };

  export const renderCreateVideoPage = async (req, res) => {
    const [examanes] = await pool.query("SELECT * FROM tbl_examenes");
    res.render("video/VideoCreate", {
      optionExamenes: examanes,
    });
  };
  
  export const createVideo = async (req, res) => {
    const { titulo, url, descripcion, imagen, watch_id, examen_id } = req.body;

    const examenId = examen_id ? examen_id : null;

    console.log(req.body);
    await pool.query(
      "INSERT INTO tbl_videos (titulo, url, descripcion, imagen, watch_id, examen_id) VALUES (?, ?, ?, ?, ?, ?)",
      [titulo, url, descripcion, imagen, watch_id, examenId]
    );
    await req.setFlash("success", "video Added Successfully");
    return res.redirect("/videoGestion");
  };

  export const editVideo = async (req, res) => {
    const { id, titulo, url, descripcion, imagen, watch_id, examen_id } = req.body;
    
    const examenId = examen_id ? examen_id : null;

    console.log("Este es el id", id);
    await pool.query(
      "UPDATE tbl_videos SET titulo = ?, url = ?, descripcion = ?, imagen = ?, watch_id = ?, examen_id = ? WHERE id = ?",
      [titulo, url, descripcion, imagen, watch_id, examenId, id]
    );
    await req.setFlash("success", "video Added Successfully");
    return res.redirect("/videoGestion");
  };
  
  export const renderEditVideo = async (req, res) => {
    const { id } = req.params;
    const [result] = await pool.query("SELECT * FROM tbl_videos WHERE id = ?", [
      id,
    ]);
    const datos = result[0];
  
    // Consulta para obtener las opciones de categoría y videos
    const [examanes] = await pool.query("SELECT * FROM tbl_examenes");
  
    res.render("video/VideoEdit", {
      datos,
      optionExamenes: examanes,
    });
  };