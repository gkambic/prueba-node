import dotenv from 'dotenv';
dotenv.config();

export const database = {
  host: process.env.AZURE_MYSQL_HOST,
  user: process.env.AZURE_MYSQL_USERNAME,
  password: process.env.AZURE_MYSQL_PASSWORD,
  database: process.env.AZURE_MYSQL_DBNAME,
  port: process.env.AZURE_MYSQL_PORT
};

export const SECRET = process.env.SECRET || 'some secret key';

export default {
  PORT: process.env.PORT || 5000,
  APPID: process.env.APPID || "",
};
