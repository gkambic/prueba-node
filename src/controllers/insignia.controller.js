import { pool } from "../database.js";
import ExcelJS  from "exceljs";

export const renderInsignias = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_insignias");
  res.render("insignia/insigniaList", { datos: rows });
};

export const renderTableInsigniaPage = async (req, res) => {

  const { nombre, descripcion, imagen_url, examen } = req.body;

  let query = ` select ti.id, ti.nombre, ti.descripcion, ti.imagen_url, te.nombre as examen 
  from tbl_insignias ti LEFT JOIN tbl_examenes te on te.id = ti.examen_id WHERE 1=1`;

  let params = [];

    if (nombre) {
      query += ' AND ti.nombre LIKE ?';
      params.push(`%${nombre}%`);
    }

    if (descripcion) {
      query += ' AND ti.descripcion LIKE ?';
      params.push(`%${descripcion}%`);
    }

    if (imagen_url) {
      query += ' AND ti.imagen_url LIKE ?';
      params.push(`%${imagen_url}%`);
    }

    if (examen) {
      query += ' AND te.nombre LIKE ?';
      params.push(`%${examen}%`);
    }

    console.log(query);
  const [rows] = await pool.query(query, params);
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

  export const exportInsignia = async (req, res) => {
    const { nombre, descripcion, imagen_url, examen } = req.body;

  let query = ` select ti.nombre, ti.descripcion, ti.imagen_url, te.nombre as examen 
  from tbl_insignias ti LEFT JOIN tbl_examenes te on te.id = ti.examen_id WHERE 1=1`;

  let params = [];

    if (nombre) {
      query += ' AND ti.nombre LIKE ?';
      params.push(`%${nombre}%`);
    }

    if (descripcion) {
      query += ' AND ti.descripcion LIKE ?';
      params.push(`%${descripcion}%`);
    }

    if (imagen_url) {
      query += ' AND ti.imagen_url LIKE ?';
      params.push(`%${imagen_url}%`);
    }

    if (examen) {
      query += ' AND te.nombre LIKE ?';
      params.push(`%${examen}%`);
    }
  
      const [rows] = await pool.query(query, params);
  
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Insignia');
  
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
        'attachment; filename="Insignias.xlsx"'
      );
      res.setHeader(
        'Content-Type',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      );
  
      await workbook.xlsx.write(res);
      res.end();
  };