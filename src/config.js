import { config } from "dotenv";
config();

export const database = {
  host: 'expertosdelcemento-dev-server.mysql.database.azure.com',
        user: 'expertosdelcementoDev',
        password: process.env.AZURE_MYSQL_PASSWORD,//'DataBase24!',
        database: 'expertosdelcemento-dev-database'
};

export const SECRET = process.env.SECRET || 'some secret key';

export default {
  PORT: process.env.PORT || 5000,
  APPID: process.env.APPID || "",
};
