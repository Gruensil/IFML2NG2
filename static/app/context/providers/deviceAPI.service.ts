 
 
// PROTECTED REGION ID deviceAPI ENABLED START
        // window.addEventListener('devicelight', event => {

        //     if (event.value > 300) {
        //         this.ambientLight = 2;
        //     }else if(event.value > 100){
        //             this.ambientLight = 1;
        //     }else{
        //         this.ambientLight = 0;
        //     }

        //     this.getAmbientLight();
        // });

        // window.addEventListener('online', event => {

        //     console.log("online" + event.returnValue);

        // });

        // Updates Movement information for vertical movement
        window.addEventListener("devicemotion", event => {

            var y = event.accelerationIncludingGravity.y;
            if (y > 9.5 || y < 7) {
                this.movement = 2;
            }else if(y > 8.7 || y < 7.5){
                    this.movement = 1;
            }else{
                this.movement = 0;
            }
        });

// PROTECTED REGION END

// PROTECTED REGION ID movement ENABLED START

// PROTECTED REGION END

// PROTECTED REGION ID deviceType ENABLED START

// PROTECTED REGION END