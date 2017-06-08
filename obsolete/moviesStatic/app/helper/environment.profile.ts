// environment context
export class EnvironmentProfile {
    constructor(
    private brightnessLevel: number)
    {};

    // set brightness on a scale from 0 to 100;
    public setBrightnessLevel(brightness: number){
        if(brightness > 100){
            this.brightnessLevel = 100;
        }else if(brightness < 0){
            this.brightnessLevel = 0;
        }else{
            this.brightnessLevel = brightness;
        }
    };

    // returns brightness level
    public getBrightnessLevel(): number{
        return this.brightnessLevel;
    }
}
