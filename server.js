var express = require("express");
var app = express();
var port = process.env.PORT || 3000;
var passport = require('passport');
var flash    = require('connect-flash');
var multer = require("multer");
var mongoose = require("mongoose");
var bodyParser = require("body-parser");
var session      = require('express-session');
var Alexa = require('alexa-sdk');

exports.handler = function(event, context, callback){
    var alexa = Alexa.handler(event, context, callback);
};
var configDB = require('./config/database.js');
mongoose.Promise = Promise;


if (!process.env.MONGODB_URI){

        mongoose.connect("mongodb://localhost/img");
    }
    else{
        mongoose.connect(process.env.MONGODB_URI)
    }
require('./config/passport')(passport); // pass passport for configuration
//app.use(morgan('dev')); // log every request to the console
//app.use(express.bodyParser({uploadDir:'./uploads'}));
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json())// parse application/json
app.use(session({
    secret: 'ilovescotchscotchyscotchscotch',
    name: "K-Closet",
    proxy: true,
    resave: true,
    saveUninitialized: true
}));
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
var db= mongoose.connection;
app.use(flash()); // use connect-flash for flash messages stored in session
  db.on("error", function(error){
  console.log("Mongoose Error",error)
  });
  db.once("open", function(error){
  console.log("Mongoose Rocks")
  });
// routes ======================================================================
require('./routes/routes.js')(app, passport); // load our routes and pass in our app and fully configured passport

app.listen(port, function() {
  console.log("The Magic running on port "+ port);
});
