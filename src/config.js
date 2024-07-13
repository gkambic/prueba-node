import { config } from "dotenv";
config();

export const database = {
  host: 'localhost',
        user: 'root',
        password: '',
        database: 'c1720260_edc'
};

export const SECRET = process.env.SECRET || 'some secret key';

export default {
  PORT: process.env.PORT || 5000,
  APPID: process.env.APPID || "",
};
