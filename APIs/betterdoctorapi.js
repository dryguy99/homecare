// /* DOCUMENTATION FOR BETTER DOCTOR API */ //



//---------- SPECIALTIES ----------//
/*
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
*/
//---------- ZIP CODE TO LAT/LNG CONVERSION ----------//

var userKey03 = "FGkX98QWG4pBdE6b5TdFIinfuhigQC8cM2q6EYov5rBtba0CcAvsdntEnz6BbJ4l";
var zipcode = "08901";

var queryURL03 = "https://cors-anywhere.herokuapp.com/https://www.zipcodeapi.com/rest/"+userKey03+"/info.json/"+zipcode+"/degrees;"


$("#button").on("click", function(){
	$.ajax({
          url: queryURL03,
          method: "GET"
        }).done(function(response) {
          
          console.log(queryURL03);

          console.log(response);

          //latitude converted from zip code
          console.log(response.lat);
          //longitude converted from zip code
          console.log(response.lng);

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
		          
		          console.log(queryURL02);
		          console.log(response);

		          for (var i = 0; i < 5; i++){
			          //name
			          console.log("----- Name: "+ response.data[i].profile.first_name +" "+ response.data[i].profile.last_name +" "+ response.data[i].profile.title+" -----");
			          
			          //matching specialties
			          console.log(response.data[i].profile.bio); 
			          //distance
				      console.log(response.data[i].practices[0].distance +" miles away from you");
				      //phone
				      console.log("Phone Number: " + response.data[i].practices[0].phones[0].number);
			          //address
				      console.log("Location: " + response.data[i].practices[0].visit_address.street +", "+ response.data[i].practices[0].visit_address.city +", "+ response.data[i].practices[0].visit_address.state +" "+ response.data[i].practices[0].visit_address.zip);
				  };

		        });
        });
});


//---------- PRACTICES ----------//
/*
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
