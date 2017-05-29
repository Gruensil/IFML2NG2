// PROTECTED REGION ID general ENABLED START
declare var google: any;

// PROTECTED REGION END


// PROTECTED REGION ID geocoding ENABLED START

    private geocoder = new google.maps.Geocoder;
    private latlng = new google.maps.LatLng({lat: 51, lng:8});

// PROTECTED REGION END


// PROTECTED REGION ID constructor ENABLED START


// PROTECTED REGION END


// PROTECTED REGION ID location ENABLED START


	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition((position: any) => {
			var la = "" + position.coords.latitude;
			var lo = "" + position.coords.longitude;
			this.latlng = new google.maps.LatLng({lat: parseFloat(la), lng: parseFloat(lo)});
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