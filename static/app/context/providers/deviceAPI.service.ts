 
 
// PROTECTED REGION ID deviceAPI ENABLED START
        window.addEventListener('devicelight', event => {
            var html = document.getElementsByTagName('html')[0];
            if (event.value > 300) {
                this.ambientLight = 2;
            }else if(event.value > 100){
                    this.ambientLight = 1;
            }else{
                this.ambientLight = 0;
            }

            this.getAmbientLight();
        });
// PROTECTED REGION END