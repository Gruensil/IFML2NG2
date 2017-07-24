// PROTECTED REGION ID general ENABLED START
declare var google: any;

// PROTECTED REGION END


// PROTECTED REGION ID geocoding ENABLED START

    private geocoder = new google.maps.Geocoder;

    //init value for latitude and longitude
    private latlng = new google.maps.LatLng({lat: 51, lng:8});
    private la;
    private lo;

    private request;
    private openWeatherMapKey = "ebc3bac589e89ccc0cf69213042400c5";
	private apixuKey = "8d10ab661a23465188a100438172306";

// PROTECTED REGION END


// PROTECTED REGION ID constructor ENABLED START


// PROTECTED REGION END


// PROTECTED REGION ID location ENABLED START


	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition((position: any) => {
			this.la = "" + position.coords.latitude;
			this.lo = "" + position.coords.longitude;
			this.latlng = new google.maps.LatLng({lat: parseFloat(this.la), lng: parseFloat(this.lo)});
		});
	} else {
		console.log('Geolocation not supported');
	}
	this.geocoder.geocode({ 'location': this.latlng }, (results: any, status:any) => {
        if (status === google.maps.GeocoderStatus.OK) {
            if (results[1]) {
                this.location = "" + results[1].formatted_address;
            } else {
                console.log('No location results found');
            }
        } else {
            console.log('Geocoder failed due to: ' + status);
        }
    });

// PROTECTED REGION END

// PROTECTED REGION ID weather ENABLED START

    // console.log('Weather is called');

	if(this.la != undefined && this.lo != undefined){
		// var requestString = "http://api.openweathermap.org/data/2.5/weather?"
		// 					+ "lat=" + this.la + "&" + "lon=" + this.lo
		// 					+ "&cluster=yes&format=json"
		// 					+ "&apikey=" + this.openWeatherMapKey;
		// this.request = new XMLHttpRequest();
		// this.request.onload = this.proccessResults;
		// this.request.open("get", requestString, true);
		// this.request.send();

		var requestString = "https://api.apixu.com/v1/current.json?"
							+ "key=" + this.apixuKey
							+ "&q=" + this.la + "," + this.lo;
		this.request = new XMLHttpRequest();
		this.request.onload = this.proccessResults;
		this.request.open("get", requestString, true);
		this.request.send();
	}

// PROTECTED REGION END

// PROTECTED REGION ID addMethods ENABLED START

    proccessResults = () => {
        var results = JSON.parse(this.request.responseText);
        // if (results != undefined) {
		// 	var condition = results.weather[0].main;
		// 	switch(condition){
		// 		case "Clear":{ this.weather = Weather.sunny; break;}

		// 		case "Rain":{ this.weather = Weather.rainy; break;}

		// 		default:{ this.weather = Weather.cloudy;}
		// 	}
        // }
		if (results != undefined) {
			var condition = results.current.condition.code;
			//console.log(condition);
			switch(condition){
				case 1000:{ this.weather = Weather.sunny; break;}

				case 1003||1006||1009||1030:{ this.weather = Weather.cloudy; break;}

				default:{ this.weather = Weather.rainy;}
			}
        }
    };

// PROTECTED REGION END