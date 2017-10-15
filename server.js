var express = require("express");
var app = express();
var port = process.env.PORT || 3000;
var passport = require('passport');
var flash    = require('connect-flash');
var multer = require("multer");
var mongoose = require("mongoose");
var bodyParser = require("body-parser");
var session      = require('express-session');
var request = require('request');

var userKey03 = "FGkX98QWG4pBdE6b5TdFIinfuhigQC8cM2q6EYov5rBtba0CcAvsdntEnz6BbJ4l";

//ideally this would be input by alex's location settings, permission from user to use
var zipcode = "08901";
var lat = 0;
var lng = 0;
request("https://www.zipcodeapi.com/rest/"+userKey03+"/info.json/"+zipcode+"/degrees", function (error, response, body) {
  console.log('error:', error); // Print the error if one occurred
  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
  console.log('body:', body); // Print the HTML for the Google homepage.
  lat = response.lat;
  lng = response.lng;

});



//---------- DOCTORS BY ZIP CODE + SPECIALTIES ----------//

var specialty = "radiology-podiatrist,pedorthist,primary-podiatry-doctor,podiatrist-general-practice,foot-ankle-orthopedist,podiatry-surgeon"
var userKey02 = "5deae9ede4889f9afe0e0dcfb8e37c70";
//var queryURL02 = "https://api.betterdoctor.com/2016-03-01/practices?location="+lat+"%2C"+lng+"%2C10&user_location="+lat+"%2C"+lng+"&skip=0&limit=10&user_key="+userKey02;
var queryURL02 = "https://api.betterdoctor.com/2016-03-01/doctors?specialty_uid="+specialty+"&location="+lat+"%2C"+lng+"%2C10&user_location="+lat+"%2C"+lng+"&skip=0&limit=10&user_key="+userKey02;

request(queryURL02, function (error, response, body) {
  console.log('error:', error); // Print the error if one occurred
  console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
  console.log('body:', body); // Print the HTML for the Google homepage.
});

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
require('./index.js');

app.listen(port, function() {
  console.log("The Magic running on port "+ port);
});
