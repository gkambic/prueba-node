/* import { pool } from "../database.js";
import ExcelJS  from "exceljs";

export const renderVideos = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_videos");
  res.render("video/videoList", { datos: rows });
};

export const renderTableVideoPage = async (req, res) => {
  const {titulo, url, watch_id, descripcion, examen } = req.body;

  let query = `select tv.id, tv.titulo, tv.url, tv.watch_id, tv.descripcion, te.nombre as examen 
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
      "select tv.id, tv.titulo, tv.url, tv.watch_id, tv.descripcion, te.nombre as examen from tbl_videos tv LEFT JOIN tbl_examenes te on tv.examen_id = te.id"
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
    const { titulo, url, descripcion, watch_id, examen_id } = req.body;

    const examenId = examen_id ? examen_id : null;

    await pool.query(
      "INSERT INTO tbl_videos (titulo, url, descripcion, watch_id, examen_id) VALUES (?, ?, ?, ?, ?, ?)",
      [titulo, url, descripcion, watch_id, examenId]
    );
    await req.setFlash("success", "video Added Successfully");
    return res.redirect("/videoGestion");
  };

  export const editVideo = async (req, res) => {
    const { id, titulo, url, descripcion, watch_id, examen_id } = req.body;
    
    const examenId = examen_id ? examen_id : null;

    await pool.query(
      "UPDATE tbl_videos SET titulo = ?, url = ?, descripcion = ?, watch_id = ?, examen_id = ? WHERE id = ?",
      [titulo, url, descripcion, watch_id, examenId, id]
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

  export const exportVideo = async (req, res) => {
    const {titulo, url, watch_id, descripcion, examen } = req.body;

  let query = `select tv.titulo, tv.url, tv.watch_id, tv.descripcion, te.nombre as examen 
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

    if (examen) {
      query += ' AND te.nombre LIKE ?';
      params.push(`%${examen}%`);
    }
  
      const [rows] = await pool.query(query, params);
  
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Video');
  
      // Agrega los encabezados
      const headers = Object.keys(rows[0]);
      worksheet.addRow(headers);
  
      // Aplica estilo a los encabezados
      worksheet.getRow(1).eachCell((cell) => {
        cell.font = { bold: true };
        cell.alignment = { vertical: 'middle', horizontal: 'center' };
        cell.fill = {
          type: 'pattern',
          pattern: 'solid',
          fgColor: { argb: 'FFFFCC00' },
        };
      });
      
      // Agrega las filas de datos
      rows.forEach(row => {
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
      res.setHeader(
        'Content-Disposition',
        'attachment; filename="videos.xlsx"'
      );
      res.setHeader(
        'Content-Type',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      );
  
      await workbook.xlsx.write(res);
      res.end();
  };
   */