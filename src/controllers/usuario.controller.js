import { pool } from "../database.js";
import ExcelJS from "exceljs";
import { formatDate } from "../lib/fechaHelper.js";

export const renderUsuarios = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_users");
  res.render("usuario/usuarioList", { datos: rows });
};

export const renderTableUsuarioPage = async (req, res) => {

  const { desde, hasta, Nombre, Apellido, Mail, Telefono, Provincia, Ciudad, Corralon, Profesion, Antiguedad, Rol, Ingresos, Cupones, Insignias, ExamenesDesaprobados, ExamenesAprobados, ExamenesAProbadosConMas90, Videos } = req.body;

  console.log(req.body);
  let query = `select * from (select name as Nombre, lastname as Apellido, email as Mail, mobile as Telefono, 
                    provincia as Provincia, ciudad as Ciudad, corralon as Corralon, 
                    profesion as Profesion, antiguedad as Antiguedad, DATE_FORMAT(u.createdDtm, '%d-%m-%Y %H:%i:%s') as FechaCreacion, 
                    tr.role as Rol, count(distinct tll.id ) Ingresos, count(distinct tcu.id) as Cupones, count(distinct tiu.id ) as Insignias,
                    ex.ExamenesDesaprobados,
                    ex.ExamenesAprobados,
                    ex.ExamenesAprobadosConMas90,
                    count(distinct thu.id) Videos
                    from tbl_roles tr, tbl_users u
                    left join tbl_last_login tll on u.userId = tll.userId 
                    left join tbl_cupones_usuarios tcu on u.userId = tcu.id_usuario 
                    left join tbl_insignias_usuario tiu on u.userId  = tiu.id_usuario 
                    left join tbl_historial_usuarios thu on u.userId = thu.id_usuario 
                    LEFT JOIN (
                    SELECT
                        id_usuario,
                        COUNT(CASE WHEN aprobado = 0 THEN 1 END) AS ExamenesDesaprobados,
                        COUNT(CASE WHEN aprobado = 1 AND puntaje <= 90 THEN 1 END) AS ExamenesAprobados,
                        COUNT(CASE WHEN aprobado = 1 AND puntaje > 90 THEN 1 END) AS ExamenesAprobadosConMas90
                    FROM
                        tbl_insignias_usuario
                    GROUP BY
                        id_usuario
                  ) ex ON u.userId = ex.id_usuario
                    where tr.roleId  = u.roleId 
                    group by name, lastname, email, mobile, provincia, ciudad, corralon, profesion, antiguedad,u.createdDtm, tr.role, ex.ExamenesDesaprobados,
                    ex.ExamenesAprobados, ex.ExamenesAprobadosConMas90) usuarios
                    where 1 = 1`;
  const params = [];

  if (desde) {
    query += ' AND createdDtm >= ?';
    params.push(desde);
  }
  if (hasta) {
    query += ' AND createdDtm <= ?';
    params.push(hasta);
  }

  if (Nombre) {
    query += ' AND name LIKE ?';
    params.push(`%${Nombre}%`);
  }

  if (Apellido) {
    query += ' AND lastname LIKE ?';
    params.push(`%${Apellido}%`);
  }

  if (Mail) {
    query += ' AND email LIKE ?';
    params.push(`%${Mail}%`);
  }

  if (Telefono) {
    query += ' AND mobile LIKE ?';
    params.push(`%${Telefono}%`);
  }

  if (Provincia) {
    query += ' AND provincia LIKE ?';
    params.push(`%${Provincia}%`);
  }

  if (Ciudad) {
    query += ' AND ciudad LIKE ?';
    params.push(`%${Ciudad}%`);
  }

  if (Corralon) {
    query += ' AND corralon LIKE ?';
    params.push(`%${Corralon}%`);
  }

  if (Profesion) {
    query += ' AND profesion LIKE ?';
    params.push(`%${Profesion}%`);
  }

  if (Antiguedad) {
    query += ' AND antiguedad = ?';
    params.push(Antiguedad);
  }

  if (Rol) {
    query += ' AND role LIKE?';
    params.push(`%${Rol}%`);
  }

  if (ExamenesDesaprobados) {
    query += ' AND ExamenesDesaprobados = ?'
    params.push(ExamenesDesaprobados);
  }

  if (Ingresos) {
    query += ' AND ingresos = ?'
    params.push(Ingresos);
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
  const [rows] = await pool.query(`SELECT userid, name as Nombre, lastname as Apellido, email as Mail, mobile as Telefono, 
                                  provincia as Provincia, ciudad as Ciudad, corralon as Corralon, 
                                  profesion as Profesion, antiguedad as Antiguedad, DATE_FORMAT(createdDtm, '%d-%m-%Y %H:%i:%s') as FechaCreacion, 
                                  tr.role as Rol
                                  from tbl_users u, tbl_roles tr 
                                  where tr.roleId  = u.roleId `);
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
