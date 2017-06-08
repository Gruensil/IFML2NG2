import { PlatformProfile } from '../helper/platform.profile';
import { UserProfile } from '../helper/user.profile';
import { EnvironmentProfile } from '../helper/environment.profile';
import { StateProfile } from '../helper/state.profile';

import { DisplayProperties } from '../helper/displayProperties'

// instance of context model
export class Profile {
    public user: UserProfile;
    public platform: PlatformProfile;
    public environment: EnvironmentProfile;
    public state: StateProfile;

    public displayProperties: DisplayProperties;

    constructor()
    {
        // initialize context profiles
        this.user = new UserProfile('',false,'false');
        this.platform = new PlatformProfile ('');
        this.environment = new EnvironmentProfile(51);
        this.state = new StateProfile();

        this.displayProperties = new DisplayProperties();

        console.log(this.user.toString())
    };
 
    // set the user role
    public setUserRole(v : string) {
        this.user.setUserRole(v);
    }

    // set if the user has weak vision
    public setUserWeakVision(v: boolean){
        this.user.setWeakVision(v);
    }

    // set if the user has high computer self-efficiacy
    public setUserComputerSelfEfficiacy(v: string){
        this.user.setComputerSelfEfficiacy(v);
    }

    // set platform type
    public setPlatformType(v : string){
        this.platform.setPlatformType(v);
    }
    
    // set environment brightness on a scale of 0 to 100
    public setEnvironmentBrightness(v: number){
        this.environment.setBrightnessLevel(v);
    }

    // get user profile
    public getUser() : UserProfile {
        return this.user;
    }
    
    // get platform profile
    public getPlatform() : PlatformProfile {
        return this.platform;
    }

    // get environment profile
    public getEnvironment() : EnvironmentProfile {
        return this.environment;
    }

    // get application state profile
    public getState() : StateProfile {
        return this.state;
    }

    // to JSON
    public toJSON() : string{
        var json : string = '';

        json += "{";
        // serialize user
        json +='"user":' + JSON.stringify(this.user) + ","
        // serialize platform
        json += '"platform":' + JSON.stringify(this.platform) + ","
        //serialize environment
        json += '"environment":' + JSON.stringify(this.environment) + ","
        // serialize displayProperties
        json += '"displayProperties":' + JSON.stringify(this.displayProperties) + "}"

        return json;
    }

}
