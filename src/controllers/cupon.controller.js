import { pool } from "../database.js";
import ExcelJS  from "exceljs";
import { formatDate } from "../lib/fechaHelper.js";

export const renderCupones = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_cupones");
  res.render("cupon/cuponList", { datos: rows });
};

export const renderTableCuponPage = async (req, res) => {
  const { codigo, desde, hasta, otorgado } = req.body;

  let query =`select * from (
    select c.id, c.codigo, DATE_FORMAT(vencimiento, '%d-%m-%Y %H:%i:%s') as vencimiento, case when tcu.id is null then 'NO' else 'SI' end otorgado
    from tbl_cupones c left join tbl_cupones_usuarios tcu on c.id = tcu.id_usuario ) as TempTable WHERE 1 = 1`;

  let params = [];

    if (codigo) {
      query += ' AND TempTable.codigo LIKE ?';
      params.push(`%${codigo}%`);
    }

    if (desde) {
      query += ' AND TempTable.vencimiento >= ?';
      params.push(desde);
    }
    if (hasta) {
      query += ' AND TempTable.vencimiento <= ?';
      params.push(hasta);
    }

    if (otorgado !== undefined && otorgado !== '') {
      query += ' AND TempTable.otorgado = ?';
      params.push(otorgado === '1' ? 'SI' : 'NO');
    }

    const [rows] = await pool.query(query, params);

  res.render("cupon/cuponTable", { datos: rows , filtros: req.body });
};

export const deleteCupon = async (req, res) => {
    const { id } = req.params;
    await pool.query("DELETE FROM tbl_cupones WHERE ID = ?", [id]);
    await req.setFlash("success", `Cupon ${id} Removed Successfully`);
    return res.redirect("/cuponGestion");
  };

  export const renderTableCuponGestion = async (req, res) => {
    const [rows] = await pool.query(
      "SELECT id, codigo, DATE_FORMAT(vencimiento, '%d-%m-%Y %H:%i:%s') as vencimiento FROM tbl_cupones WHERE 1 = 1"
    );
    res.render("cupon/cuponGestion", { datos: rows });
  };

  export const renderCreateCuponPage = async (req, res) => {
    const [categorias] = await pool.query("SELECT * FROM tbl_categorias");
    const [videos] = await pool.query("SELECT * FROM tbl_videos");
    res.render("cupon/CuponCreate", {
      optionsCategory: categorias,
      optionVideos: videos,
    });
  };
  
  export const createCupon = async (req, res) => {
    const { codigo, vencimiento } = req.body;
    console.log(req.body);
    await pool.query(
      "INSERT INTO tbl_cupones (codigo, vencimiento) VALUES (?, ?)",
      [codigo, vencimiento]
    );
    await req.setFlash("success", "cupon Added Successfully");
    return res.redirect("/cuponTable");
  };

  export const editCupon = async (req, res) => {
    const {id, codigo, vencimiento } = req.body;
    
    await pool.query(
      "UPDATE tbl_cupones SET codigo = ?, vencimiento = ? WHERE id = ?",
      [codigo, vencimiento, id]
    );
    await req.setFlash("success", "cupon Added Successfully");
    return res.redirect("/cuponGestion");
  };
  
  export const renderEditCupon = async (req, res) => {
    const { id } = req.params;
    const [result] = await pool.query("SELECT id, codigo, DATE_FORMAT(vencimiento, '%Y-%m-%d') as vencimiento FROM tbl_cupones WHERE id = ?", [
      id,
    ]);
    const datos = result[0];
  console.log(datos);
    res.render("cupon/CuponEdit", {
      datos
    });
  };

  export const exportCupon = async (req, res) => {
    const { codigo, desde, hasta, otorgado } = req.body;
    let query =`select * from (
      select c.id, c.codigo, DATE_FORMAT(vencimiento, '%d-%m-%Y %H:%i:%s') as vencimiento, case when tcu.id is null then 'NO' else 'SI' end otorgado
      from tbl_cupones c left join tbl_cupones_usuarios tcu on c.id = tcu.id_usuario ) as TempTable WHERE 1 = 1`;
  
    let params = [];
  
      if (codigo) {
        query += ' AND TempTable.codigo LIKE ?';
        params.push(`%${codigo}%`);
      }
  
      if (desde) {
        query += ' AND TempTable.vencimiento >= ?';
        params.push(desde);
      }
      if (hasta) {
        query += ' AND TempTable.vencimiento <= ?';
        params.push(hasta);
      }
  
      if (otorgado !== undefined && otorgado !== '') {
        query += ' AND TempTable.otorgado = ?';
        params.push(otorgado === '1' ? 'SI' : 'NO');
      }
  
      console.log(query);
  
      const [rows] = await pool.query(query, params);
  
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Cupones');
  
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
        'attachment; filename="cupones.xlsx"'
      );
      res.setHeader(
        'Content-Type',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      );
  
      await workbook.xlsx.write(res);
      res.end();
  };
  