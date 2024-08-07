import express from "express";
import path from "path";
import morgan from "morgan";
import routes from "./routes/index.js";
import session from "express-session";
import expressMySQLSession from "express-mysql-session";

import { SECRET, database } from "./config.js";
import config from "./config.js";
import {fileURLToPath} from "url";
import { pool } from "./database.js";
import passport from "passport";
import { promiseConnectFlash } from "async-connect-flash";
const app = express();
import "./lib/passport.js";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const MySQLStore = expressMySQLSession(session);
// Settings
app.set("port", config.PORT);
app.set("views", path.resolve(__dirname, "views"));
app.set("view engine", "ejs");

// Middlewares
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));

app.use(
  session({
    secret: SECRET,
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore({}, pool),
  })
);
app.use(promiseConnectFlash());
//app.use(promiseConnectFlash());
app.use(passport.initialize());
app.use(passport.session());

// global variables
app.use(async (req, res, next) => {
  app.locals.success = await req.getFlash("success");
  app.locals.error = await req.getFlash("error");
  app.locals.user = req.user;
  app.locals.APPID = config.APPID;
  next();
});


// Routes
app.use(routes);

app.use(express.static(path.join(__dirname, "public")));

// 404 handler
app.use((req, res, next) => {
  res.status(404).render("404");
});

export default app;
