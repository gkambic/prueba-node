const express = require("express");
const app = express();
const PORT = 8080;
const userData = require("../MOCK_DATA.json");
const graphql = require("graphql")
const { GraphQLObjectType, GraphQLSchema, GraphQLList, GraphQLID, GraphQLInt, GraphQLString } = graphql
const { graphqlHTTP } = require("express-graphql")
const { engine } = require('express-handlebars');
const path = require('path');


//settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', engine({
    defaultLayout: 'main',
    extname: '.hbs',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    helpers: require('./lib/handlebars')
}));

app.set('view engine','.hbs');

//Middlewares
app.use(morgan('dev'));
app.use(express.urlencoded({extended: false}));
app.use(express.json());

//Global Variables
app.use((req, res, next) => {
    next();
    
    });

//Routes
app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use('/links', require('./routes/links'));

app.get("/rest/getAllUsers", (req, res) => {
    res.send(userData)
   });


app.listen(PORT, () => {
  console.log("Server running");
});