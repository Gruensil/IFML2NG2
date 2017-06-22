// PROTECTED REGION ID deviceAPI ENABLED START
    private acceleartionAvg = 0.5;      // helper for moving average with magic starting value
    // private i = 0;                    // helper for debugging
// PROTECTED REGION END 
 

// PROTECTED REGION ID constructor ENABLED START

        //Ambientlight not implemented!!
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

        // Updates Movement information for vertical movement
        window.addEventListener("devicemotion", event => {

            /*  x,y,z are the accelerations on different axis.
                All combined have a value in still position of ~13.
                This is due acceleration of gravtiy.
                If the device is shaken or moved the value rises.                
            */
            
            var x = event.accelerationIncludingGravity.x;
            var y = event.accelerationIncludingGravity.y;
			var z = event.accelerationIncludingGravity.z;

			var w = y+z+x;

            /*  If the combined acceleration rises above a level
                a moving average is increased. All the used magic values and threshold
                are eperimental and turned out to work fine
            */

            this.acceleartionAvg = this.acceleartionAvg*24;
            if(w > 14 || w < 8.5){
                this.acceleartionAvg += 100;
            }
            this.acceleartionAvg = this.acceleartionAvg/25;

            // if(this.i == 100){
            //     console.log(this.acceleartionAvg);
            //     this.i=0;
            // }else{
            //     this.i++;
            // }

            if(this.acceleartionAvg >= 1){
                this.movement = 2;
            }else if(this.acceleartionAvg >= 0.5){
                this.movement = 1;
            }else{
                this.movement = 0;
            }

        });



// PROTECTED REGION END


// PROTECTED REGION ID movement ENABLED START

// PROTECTED REGION END


// PROTECTED REGION ID language ENABLED START
            switch(navigator.language){
                case "de": this.language = Language.german; break;

                case "en"||"en-us": this.language = Language.english; break;

                case "it": this.language = Language.italian; break;

                default: this.language = Language.english;
            }
// PROTECTED REGION END


// PROTECTED REGION ID deviceType ENABLED START
            if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|BB|PlayBook|IEMobile|Windows Phone|Kindle|Silk|Opera Mini|Mobile/.test(navigator.userAgent)){
                this.deviceType = "mobile";
            }else{
                this.deviceType = "desktop";
            }
// PROTECTED REGION END