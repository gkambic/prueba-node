import { pool } from "../database.js";


export const renderCupones = async (req, res) => {
  const [rows] = await pool.query("SELECT * FROM tbl_cupones");
  res.render("cupon/cuponList", { datos: rows });
};

export const renderTableCuponPage = async (req, res) => {
  const { codigo } = req.body;
  let query ="SELECT * FROM tbl_cupones WHERE 1 = 1";

  let params = [];

    if (codigo) {
      query += ' AND codigo LIKE ?';
      params.push(`%${codigo}%`);
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
      "SELECT * FROM tbl_cupones WHERE 1 = 1"
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
    console.log("Este es el id", id);
    await pool.query(
      "UPDATE tbl_cupones SET codigo = ?, vencimiento = ? WHERE id = ?",
      [codigo, vencimiento, id]
    );
    await req.setFlash("success", "cupon Added Successfully");
    return res.redirect("/cuponGestion");
  };
  
  export const renderEditCupon = async (req, res) => {
    const { id } = req.params;
    const [result] = await pool.query("SELECT * FROM tbl_cupones WHERE id = ?", [
      id,
    ]);
    const datos = result[0];
  
    res.render("cupon/CuponEdit", {
      datos
    });
  };