// PROTECTED REGION ID faceDetection ENABLED START
        // var affdex: any;
        // var $: any;
        // var divRoot = $("#affdex_elements")[0];

        // // The captured frame's width in pixels
        // var width = 160;

        // // The captured frame's height in pixels
        // var height = 120;

        // /*
        // Face detector configuration - If not specified, defaults to
        // affdex.FaceDetectorMode.LARGE_FACES
        // */
        // var faceMode = affdex.FaceDetectorMode.LARGE_FACES;

        // //Construct a CameraDetector and specify the image width / height and face detector mode.
        // var detector = new affdex.CameraDetector(divRoot, width, height, faceMode);
        // $( "#affdex_elements" ).hide();

        // detector.detectExpressions.smile = true;
        // detector.detectAppearance.gender = true;

        // //Add a callback to notify when the detector is initialized and ready for runing.
        // detector.addEventListener("onInitializeSuccess", () => {
        //     console.log("The detector reports initialized");
        //     //Display canvas instead of video feed because we want to draw the feature points on it
        //     $("#face_video_canvas").css("display", "none");
        //     $("#face_video").css("display", "none");  
        // });

        // //Add a callback to notify when camera access is allowed
        // detector.addEventListener("onWebcamConnectSuccess", () => {
        //     console.log("Webcam access allowed");
        // });

        // //Add a callback to notify when camera access is denied
        // detector.addEventListener("onWebcamConnectFailure", () => {
        //     console.log("webcam denied");
        // });

        // //Add a callback to notify when detector is stopped
        // detector.addEventListener("onStopSuccess", () => {
        //     console.log("The detector reports stopped");
        // });

        // detector.addEventListener("onImageResultsSuccess", (faces: any, image: any, timestamp:any) => {
        //     console.log("Timestamp: " + timestamp.toFixed(2));
        //     console.log("Number of faces found: " + faces.length);
        //     if (faces.length > 0) {
        //         //If joy of the first face is over 50% then show in log
        //         console.log("Emotions: " + JSON.stringify(faces[0].emotions, function(key, val) {
        //             return val.toFixed ? Number(val.toFixed(0)) : val;
        //         }));
        //         if(faces[0].emotions.joy>30){
        //             console.log("You are Happy! ");
        //         }else{
        //             console.log("You are definetly not happy");
        //         }
        //     }           
        // });

        // detector.start();

// PROTECTED REGION END