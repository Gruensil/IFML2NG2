import { Injectable } from '@angular/core';

@Injectable()
export class GeolocationProvider {

    constructor() { 

    }

    getLocation(){
        if (navigator.geolocation) {
            console.log('Geolocation is supported!');
            
        }
        else {
            console.log('Geolocation is not supported for this Browser/OS.');
        }
    }
}