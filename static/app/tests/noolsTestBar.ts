import { Component } from '@angular/core';
//import { ProfileService } from '../services/profile.service';
import { AuthenticationService } from '../services/authentication.service';
//import { Profile } from '../helper/profile'
import { ContextControllerService } from '../context/contextController.service';


@Component({
    selector: 'noolstestbar',
    template: `
        <div class="row container" >
            <div class="col-sm-3">
                <div class="checkbox">
                    <label><input type="checkbox" [(ngModel)]="active" (ngModelChange)="setActivation()">Context Tracking</label>
                </div>
            </div>
        </div>
        
        <a (click)="logout()" href="">Click Here to logout</a>
    	`
})

// class for testing nools by setting context attributes in a ui bar
export class NoolsTestBarComponent {
  
    private active: boolean;

//    private profile: Profile;  
//
//    private userWeakVision: boolean;
//    private userSelfEfficiacy: string;
//
//    private language: string;
//
//    private platformType: string;
//
//    private environmentBrightness: number;

    constructor(
        private _service : AuthenticationService,
        //private _profile :ProfileService,
        private _context : ContextControllerService
    ) {
//            this.userWeakVision = _profile.getProfile().getUser().hasWeakVision();
//            this.userSelfEfficiacy = _profile.getProfile().getUser().hasHighComputerSelfEfficiacy();
//            this.isAdmin = _profile.getProfile().getUser().getIsAdmin();
//            this.language = _profile.getProfile().getUser().getLanguage();
//
//            this.platformType = _profile.getProfile().getPlatform().getPlatformType();
//
//            this.environmentBrightness = _profile.getProfile().getEnvironment().getBrightnessLevel();
        }

    // input for device changed
//    deviceChanged(){
//        this._profile.setPlatformType(this.platformType);
//    }
//
//    // input for vision changed
//    visionChanged(){
//        this._profile.setWeakVision(this.userWeakVision);
//    }
//    
//    // input for self efficiacy changed
//    selfEfficiacyChanged(){
//        this._profile.setComputerSelfEfficiacy(this.userSelfEfficiacy);
//    }
//    
//    // input for environment brightness changed
//    brightnessChanged(){
//        this._profile.setBrightnessLevel(this.environmentBrightness);
//    }
//
//    //input for is admin changed
//    isAdminChanged(){
//        this._profile.setIsAdmin(this.isAdmin);
//    }
//
//    //input for is language changed
//    isLanguageChanged(){
//        this._profile.setLanguage(this.language);
//    }
//    
    logout() {
        this._service.logout();
    }
  
    setActivation(){
        this._context.setActivation(this.active);
    }
}