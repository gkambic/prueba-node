import { pool } from "../database.js";
import ExcelJS  from "exceljs";

export const renderExamenes = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_examenes");
  res.render("examen/examenList", { datos: rows });
};

export const renderTableExamenPage = async (req, res) => {
  const { nombre, url, categoria, aprobado, provincia, localidad, profesion } = req.body;

    let query = `
    SELECT
    e.id,
    e.nombre,
    e.url,
    tc.nombre as categoria,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'Name', u.Name,
            'Lastname', u.Lastname,
            'Aprobado', case iu.Aprobado when 1 then 'SI' when 0 then 'NO' else null end,
            'Puntaje', iu.Puntaje,
            'Mobile', u.Mobile,
            'Dni', u.Dni,
            'Provincia', u.Provincia,
            'Ciudad', u.Ciudad,
            'Corralon', u.Corralon,
            'TrabajadorContruccion', u.trabajador_contruccion ,
            'Profesion', u.Profesion
        )
    ) AS Usuarios
FROM tbl_categorias tc 
inner join tbl_examenes e on e.categoria_id  = tc.id 
LEFT JOIN tbl_insignias i ON i.examen_id = e.Id
LEFT JOIN tbl_insignias_usuario iu ON i.Id = iu.id_insignia 
LEFT JOIN tbl_users u ON iu.id_usuario = u.userId 
WHERE 1 = 1 `;

    let params = [];

    if (nombre) {
      query += ' AND e.nombre LIKE ?';
      params.push(`%${nombre}%`);
    }
    if (url) {
      query += ' AND e.url LIKE ?';
      params.push(`%${url}%`);
    }
    
    if (categoria) {
      query += ' AND tc.id = ?';
      params.push(categoria);
    }

    if (aprobado !== undefined && aprobado !== '') {
      if (aprobado==='2') {
        query += ' AND iu.puntaje >=90';
      } else {
        query += ' AND iu.Aprobado = ?';
        params.push(aprobado);
      }
    }
    
    if (provincia) {
      query += " AND u.Provincia LIKE ?";
      params.push(`%${provincia}%`);
    }

    if (localidad) {
      query += " AND u.Ciudad LIKE ?";
      params.push(`%${localidad}%`);
    }

    if (profesion) {
      query += " AND u.Profesion LIKE ?";
      params.push(`%${profesion}%`);
    }

    query += ` 
    GROUP BY e.Id, e.Nombre, e.url , tc.nombre 
    ORDER BY e.Id`;

    const [rows] = await pool.query(query, params);

    const [categorias] = await pool.query("SELECT * FROM tbl_categorias");

    res.render('examen/examenTable', { datos: rows , filtros: req.body, categorias });
};

export const renderTableExamenGestion = async (req, res) => {
  const [rows] = await pool.query(`
    SELECT te.id, te.nombre, te.url, tc.nombre AS categoria
    FROM tbl_examenes te
    LEFT JOIN tbl_categorias tc ON te.categoria_id = tc.id
  `);
  res.render("examen/examenGestion", { datos: rows });
};

export const deleteExamen = async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM tbl_examenes WHERE ID = ?", [id]);
  await req.setFlash("success", `examen ${id} Removed Successfully`);
  return res.redirect("/examenGestion");
};

export const renderCreateExamenPage = async (req, res) => {
  const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
  res.render("examen/ExamenCreate", {
    optionsCategory: categorias,
  });
};

export const createExamen = async (req, res) => {
  const { nombre, url, categoria_id } = req.body;
    
  // Usar null en lugar de valores vacíos
    const categoriaId = categoria_id ? categoria_id : null;

  await pool.query(
    "INSERT INTO tbl_examenes (nombre, url, categoria_id) VALUES (?, ?, ?)",
    [nombre, url, categoriaId]
  );
  await req.setFlash("success", "examen Added Successfully");
  return res.redirect("/examenGestion");
};

export const editExamen = async (req, res) => {
  const { id, nombre, url, categoria_id } = req.body;
  await pool.query(
    "UPDATE tbl_examenes SET nombre = ?, url = ?, categoria_id = ? WHERE id = ?",
    [nombre, url, categoria_id, id]
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

  // Consulta para obtener las opciones de categoría
  const [categorias] = await pool.query("SELECT * FROM tbl_categorias");

  res.render("examen/ExamenEdit", {
    datos,
    optionsCategory: categorias,
  });
};

export const exportExamen = async (req, res) => {
  const { nombre, url, categoria } = req.body;
  
    let query = `
    SELECT te.nombre, te.url, tc.nombre AS categoria
    FROM tbl_examenes te
    LEFT JOIN tbl_categorias tc ON te.categoria_id = tc.id
    WHERE 1 = 1`;
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
      query += ' AND tc.id = ?';
      params.push(categoria);
    }

    const [rows] = await pool.query(query, params);

    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Examenes');

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
      'attachment; filename="examenes.xlsx"'
    );
    res.setHeader(
      'Content-Type',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    );

    await workbook.xlsx.write(res);
    res.end();
};
