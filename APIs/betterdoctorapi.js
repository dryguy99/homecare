// /* DOCUMENTATION FOR BETTER DOCTOR API */ //

//---------- ZIP CODE TO LAT/LNG CONVERSION ----------//

var userKey03 = "FGkX98QWG4pBdE6b5TdFIinfuhigQC8cM2q6EYov5rBtba0CcAvsdntEnz6BbJ4l";

//ideally this would be input by alex's location settings, permission from user to use
var zipcode = "08901";

var queryURL03 = "https://cors-anywhere.herokuapp.com/https://www.zipcodeapi.com/rest/"+userKey03+"/info.json/"+zipcode+"/degrees;"

var doctorsObject = [];

$("#button").on("click", function(){
	$.ajax({
          url: queryURL03,
          method: "GET"
        }).done(function(response) {
          
          //console.log(queryURL03);

          //console.log(response);

          //latitude converted from zip code
          //console.log(response.lat);
          //longitude converted from zip code
          //console.log(response.lng);

          var lat = response.lat;
          var lng = response.lng;

//---------- DOCTORS BY ZIP CODE + SPECIALTIES ----------//

          var specialty = "radiology-podiatrist,pedorthist,primary-podiatry-doctor,podiatrist-general-practice,foot-ankle-orthopedist,podiatry-surgeon"
          var userKey02 = "5deae9ede4889f9afe0e0dcfb8e37c70";
          //var queryURL02 = "https://api.betterdoctor.com/2016-03-01/practices?location="+lat+"%2C"+lng+"%2C10&user_location="+lat+"%2C"+lng+"&skip=0&limit=10&user_key="+userKey02;
          var queryURL02 = "https://api.betterdoctor.com/2016-03-01/doctors?specialty_uid="+specialty+"&location="+lat+"%2C"+lng+"%2C10&user_location="+lat+"%2C"+lng+"&skip=0&limit=10&user_key="+userKey02;

	          $.ajax({
	          url: queryURL02,
	          method: "GET"
		        }).done(function(response) {
		          
		          //console.log(queryURL02);
		          //console.log(response);

              //var doctorsObject = [];

		          for (var i = 0; i < 5; i++){
			          
                //name
			          //console.log("----- Name: "+ response.data[i].profile.first_name +" "+ response.data[i].profile.last_name +" "+ response.data[i].profile.title+" -----");
			          //bio
			          //console.log(response.data[i].profile.bio); 
			          //distance
				        //console.log(response.data[i].practices[0].distance +" miles away from you");
				        //phone
				        //console.log("Phone Number: " + response.data[i].practices[0].phones[0].number);
			          //address
				        //console.log("Location: " + response.data[i].practices[0].visit_address.street +", "+ response.data[i].practices[0].visit_address.city +", "+ response.data[i].practices[0].visit_address.state +" "+ response.data[i].practices[0].visit_address.zip);
				      
                var name = response.data[i].profile.first_name +" "+ response.data[i].profile.last_name +" "+ response.data[i].profile.title;
                var bio = response.data[i].profile.bio;
                var distance = response.data[i].practices[0].distance;
                var phone = response.data[i].practices[0].phones[0].number;
                var address = response.data[i].practices[0].visit_address.street +", "+ response.data[i].practices[0].visit_address.city +", "+ response.data[i].practices[0].visit_address.state +" "+ response.data[i].practices[0].visit_address.zip;

                var doctors = {
                  name: name,
                  bio: bio,
                  distance: distance,
                  phone: phone,
                  address: address
                };

                doctorsObject.push(doctors); 

              };

		        });

        });

});





function sendData() {
    $.ajax({
        url: '/helloworld',
        type: 'POST',
        data: { json: JSON.stringify({
            doctorsObject
        })},
        dataType: 'json'
    });
};

var doctorsJSON = JSON.stringify(doctorsObject);



// app/routes.js
function myRoutes(app, passport) {

    // =====================================
    // HOME PAGE (with login links) ========
    // =====================================
    app.get('/user', function(req, res) {
      var loggedIn = false;
      if (req.user) {
        // logged in
        loggedIn = true;
        res.send(loggedIn);
      } else {
        // not logged in
        res.send(loggedIn);
      }

    });

    // =====================================
    // LOGIN ===============================
    // =====================================
    // show the login form
    app.get('/login', function(req, res) {

        // render the page and pass in any flash data if it exists
        res.render('login.ejs', { message: req.flash('loginMessage') });
    });

    // process the login form
    // process the login form
   app.post('/login', passport.authenticate('local-login', {
       successRedirect : '/', // redirect to the secure profile section
       failureRedirect : '/login', // redirect back to the signup page if there is an error
       failureFlash : true // allow flash messages
   }));

    // =====================================
    // SIGNUP ==============================
    // =====================================
    // show the signup form
    app.get('/signup', function(req, res) {

        // render the page and pass in any flash data if it exists
        res.render('signup.ejs', { message: req.flash('signupMessage') });
    });

    // process the signup form
    app.post('/signup', passport.authenticate('local-signup', {
        successRedirect : '/', // redirect to the secure profile section
        failureRedirect : '/signup', // redirect back to the signup page if there is an error
        failureFlash : true // allow flash messages
    }));

    // =====================================
    // PROFILE SECTION =====================
    // =====================================
    // we will want this protected so you have to be logged in to visit
    // we will use route middleware to verify this (the isLoggedIn function)
    app.get('/profile', isLoggedIn, function(req, res) {
      res.render('profile.ejs', {
          user : req.user // get the user out of session and pass to template
      });
    });
    // =====================================
    // FACEBOOK ROUTES =====================
    // =====================================
    // route for facebook authentication and login
    app.get('/auth/facebook', passport.authenticate('facebook', { scope : 'email' }));

    // handle the callback after facebook has authenticated the user
    app.get('/auth/facebook/callback',
        passport.authenticate('facebook', {
            successRedirect : '/',
            failureRedirect : '/'
        }));

    // =====================================
    // TWITTER ROUTES ======================
    // =====================================
    // route for twitter authentication and login
    app.get('/auth/twitter', passport.authenticate('twitter'));

    // handle the callback after twitter has authenticated the user
    app.get('/auth/twitter/callback',
        passport.authenticate('twitter', {
            successRedirect : '/',
            failureRedirect : '/'
        }));

        // =====================================
        // GOOGLE ROUTES =======================
        // =====================================
        // send to google to do the authentication
        // profile gets us their basic information including their name
        // email gets their emails
        app.get('/auth/google', passport.authenticate('google', { scope : ['profile', 'email'] }));

        // the callback after google has authenticated the user
        app.get('/auth/google/callback',
                passport.authenticate('google', {
                        successRedirect : '/',
                        failureRedirect : '/'
                }));


    // =====================================
    // LOGOUT ==============================
    // =====================================
    app.get('/logout', function (req, res){
      req.session.destroy(function (err) {
        res.send("");
      // res.redirect('/'); //Inside a callback… bulletproof!
      });
    });

    // =============================================================================
    // AUTHORIZE (ALREADY LOGGED IN / CONNECTING OTHER SOCIAL ACCOUNT) =============
    // =============================================================================

        // locally --------------------------------
            app.get('/connect/local', function(req, res) {
                res.render('connect-local.ejs', { message: req.flash('loginMessage') });
            });
            app.post('/connect/local', passport.authenticate('local-signup', {
                successRedirect : '/profile', // redirect to the secure profile section
                failureRedirect : '/connect/local', // redirect back to the signup page if there is an error
                failureFlash : true // allow flash messages
            }));

        // facebook -------------------------------

            // send to facebook to do the authentication
            app.get('/connect/facebook', passport.authorize('facebook', { scope : 'email' }));

            // handle the callback after facebook has authorized the user
            app.get('/connect/facebook/callback',
                passport.authorize('facebook', {
                    successRedirect : '/profile',
                    failureRedirect : '/'
                }));

        // twitter --------------------------------

            // send to twitter to do the authentication
            app.get('/connect/twitter', passport.authorize('twitter', { scope : 'email' }));

            // handle the callback after twitter has authorized the user
            app.get('/connect/twitter/callback',
                passport.authorize('twitter', {
                    successRedirect : '/profile',
                    failureRedirect : '/'
                }));

        // google ---------------------------------

            // send to google to do the authentication
            app.get('/connect/google', passport.authorize('google', { scope : ['profile', 'email'] }));

            // the callback after google has authorized the user
            app.get('/connect/google/callback',
                passport.authorize('google', {
                    successRedirect : '/profile',
                    failureRedirect : '/'
                }));

                // =============================================================================
        // UNLINK ACCOUNTS =============================================================
        // =============================================================================
        // used to unlink accounts. for social accounts, just remove the token
        // for local account, remove email and password
        // user account will stay active in case they want to reconnect in the future

        // local -----------------------------------
        app.get('/unlink/local', function(req, res) {
            var user            = req.user;
            user.local.email    = undefined;
            user.local.password = undefined;
            user.save(function(err) {
                res.redirect('/profile');
            });
        });

        // facebook -------------------------------
        app.get('/unlink/facebook', function(req, res) {
            var user            = req.user;
            user.facebook.token = undefined;
            user.save(function(err) {
                res.redirect('/profile');
            });
        });

        // twitter --------------------------------
        app.get('/unlink/twitter', function(req, res) {
            var user           = req.user;
            user.twitter.token = undefined;
            user.save(function(err) {
               res.redirect('/profile');
            });
        });

        // google ---------------------------------
        app.get('/unlink/google', function(req, res) {
            var user          = req.user;
            user.google.token = undefined;
            user.save(function(err) {
               res.redirect('/profile');
            });
        });

// route middleware to make sure a user is logged in
function isLoggedIn(req, res, next) {

    // if user is authenticated in the session, carry on
    if (req.isAuthenticated())
        return next();

    // if they aren't redirect them to the home page
    res.redirect('/');
}


};

module.exports = myRoutes;



/*
//---------- SPECIALTIES ----------//

var userKey01 = "5deae9ede4889f9afe0e0dcfb8e37c70";

var queryURL01 = "https://api.betterdoctor.com/2016-03-01/specialties?user_key="+userKey01;

$("#button").on("click", function(){
  $.ajax({
          url: queryURL01,
          method: "GET"
        }).done(function(response) {
          
          console.log(queryURL01);

          console.log("-----"+response.data[50].uid+"-----");
          console.log(response.data[50].name);
          console.log(response.data[50].description);
          console.log(response.data[50].actor);

          console.log("-----"+response.data[59].uid+"-----");
          console.log(response.data[59].name);
          console.log(response.data[59].description);
          console.log(response.data[59].actor);

          console.log("-----"+response.data[77].uid+"-----");
          console.log(response.data[77].name);
          console.log(response.data[77].description);
          console.log(response.data[77].actor);

          console.log("-----"+response.data[178].uid+"-----");
          console.log(response.data[178].name);
          console.log(response.data[178].description);
          console.log(response.data[178].actor);

          console.log("-----"+response.data[255].uid+"-----");
          console.log(response.data[255].name);
          console.log(response.data[255].description);
          console.log(response.data[255].actor);

          console.log("-----"+response.data[291].uid+"-----");
          console.log(response.data[291].name);
          console.log(response.data[291].description);
          console.log(response.data[291].actor);

          console.log(response);

        });
});


//---------- PRACTICES ----------//

//var userKey02 = "5deae9ede4889f9afe0e0dcfb8e37c70";
//var doctorZipCode = "08901";
//var userSlug = "nj-denville";
//var doctorSlug = 
//var userZipCode = "";

//console.log(lat);
//console.log(lng);



var queryURL02 = "https://api.betterdoctor.com/2016-03-01/practices?location="+lat+"%2C"+lng+"&user_location="+lat+"%2C"+lng+"&skip=0&limit=10&user_key="+userKey02;

$("#button").on("click", function(){
	$.ajax({
          url: queryURL02,
          method: "GET"
        }).done(function(response) {
          
          console.log(queryURL02);

          //console.log("-----"+response.data[0].location_slug+"-----");
          //console.log(response.data[50].name);
          //console.log(response.data[50].description);
          //console.log(response.data[50].actor);

          console.log(response);

        });

});
*/
