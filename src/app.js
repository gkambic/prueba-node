import express from "express";
import path from "path";
import morgan from "morgan";
import routes from "./routes/index.js";
import passport from "passport";
import session from "express-session";
import expressMySQLSession from "express-mysql-session";
import { promiseConnectFlash } from "async-connect-flash";

import { SECRET, database } from "./config.js";
import config from "./config.js";
import {fileURLToPath} from "url";
import { pool } from "./database.js";
import "./lib/passport.js";

const app = express();
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const MySQLStore = expressMySQLSession(session);
// Settings
app.set("port", config.PORT);
app.set("views", path.resolve(__dirname, "views"));
app.set("view engine", "ejs");

// Middlewares
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));

// global variables
app.use((req, res, next) => {
  console.log(config.APPID)
  app.locals.APPID = config.APPID;
  next();
});


console.log(database);
app.use(
  session({
    secret: SECRET,
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore({}, pool),
  })
);

app.use(promiseConnectFlash());
app.use(passport.initialize());
app.use(passport.session());
// Routes
app.use(routes);

app.use(express.static(path.join(__dirname, "public")));

// 404 handler
app.use((req, res, next) => {
  res.status(404).render("404");
});

export default app;
