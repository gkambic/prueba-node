import passport from "passport";
import { Strategy as LocalStrategy } from "passport-local";

import { pool } from "../database.js";
import { encryptPassword, matchPassword } from "./helpers.js";

passport.use('local', new LocalStrategy({
  usernameField: 'username',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, res) => {
  const { username, password } = req.body;
  try {

    /* const hashedPassword = await bcrypt.hash(password, 10);
    await pool.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword]); */
    req.flash('success', 'User created successfully.');
    res.redirect('/UsuarioGestion'); // Redirect to login page or any other page
  } catch (err) {
    req.flash('message', 'Error creating user.');
    res.redirect('/createUsuario'); // Redirect to register page or any other page
  }
}));

passport.use(
  "local.signin",
  new LocalStrategy(
    {
      usernameField: "email",
      passwordField: "password",
      passReqToCallback: true,
    },
    async (req, email, password, done) => {
      const [rows] = await pool.query("SELECT * FROM tbl_users WHERE email = ?", [
        email,
      ]);

      if (!rows.length) {
        await req.setFlash("error", "No user found");
        return done(null, false);
      }

      const user = rows[0];

      const validPassword = await matchPassword(password, user.password);

      if (!validPassword) {
        await req.setFlash("error", "Incorrect Password");
        return done(null, false);
      }

      done(null, user);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user.userId);
});

passport.deserializeUser(async (id, done) => {
  const [rows] = await pool.query("SELECT * FROM tbl_users WHERE userId = ?", [id]);
  done(null, rows[0]);
});

export default passport;