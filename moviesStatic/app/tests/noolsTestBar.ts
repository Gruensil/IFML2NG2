import {Component} from '@angular/core';
import { ProfileService } from '../services/profile.service';
import { AuthenticationService } from '../services/authentication.service';
import { Profile } from '../helper/profile'

@Component({
    selector: 'noolstestbar',
    template: `
        <div class="row container" >
            <div class="col-sm-3">
                <div class="form-inline form-group">
                    <label for="deviceSelect">Device</label>
                    <select class="form-control" id="deviceSelect" [(ngModel)]="platformType" (ngModelChange)="deviceChanged()">
                        <option value="desktop">desktop</option>
                        <option value="mobile">mobile</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-inline form-group">
                    <label for="visionSelect">Vision?</label>
                    <select class="form-control" id="visionSelect" [(ngModel)]="userWeakVision" (ngModelChange)="visionChanged()">
                        <option value="false">no</option>
                        <option value="true">yes</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-inline form-group">
                    <label for="seSelect">Self-efficiacy?</label>
                    <select class="form-control" id="seSelect" [(ngModel)]="userSelfEfficiacy" (ngModelChange)="selfEfficiacyChanged()">
                        <option value="false">no</option>
                        <option value="true">yes</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-inline form-group">
                    <label for="brightnessLevel">Brightness</label>
                    <input class="form-control" type="range" id="brightnessLevel" min="0" max="100" [(ngModel)]="environmentBrightness" (ngModelChange)="brightnessChanged()"> {{environmentBrightness}}
                </div>
            </div>
            <div class="col-sm-3">
                <div class="checkbox">
                    <label><input type="checkbox" [(ngModel)]="isAdmin" (ngModelChange)="isAdminChanged()">Admin?</label>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-inline form-group">
                    <label for="langSelect">Language</label>
                    <select class="form-control" id="langSelect" [(ngModel)]="language" (ngModelChange)="isLanguageChanged()">
                        <option value="enus">English</option>
                        <option value="dede">Deutsch</option>
                    </select>
                </div>
            </div>
        </div>
        
        <a (click)="logout()" href="">Click Here to logout</a>
    	`
})

// class for testing nools by setting context attributes in a ui bar
export class NoolsTestBarComponent {

    private profile: Profile;

    private userWeakVision: boolean;
    private userSelfEfficiacy: string;
    private isAdmin: boolean;
    private language: string;

    private platformType: string;

    private environmentBrightness: number;

    constructor(
        private _service : AuthenticationService,
        private _profile:ProfileService) {
            this.userWeakVision = _profile.getProfile().getUser().hasWeakVision();
            this.userSelfEfficiacy = _profile.getProfile().getUser().hasHighComputerSelfEfficiacy();
            this.isAdmin = _profile.getProfile().getUser().getIsAdmin();
            this.language = _profile.getProfile().getUser().getLanguage();

            this.platformType = _profile.getProfile().getPlatform().getPlatformType();

            this.environmentBrightness = _profile.getProfile().getEnvironment().getBrightnessLevel();
        }

    // input for device changed
    deviceChanged(){
        this._profile.setPlatformType(this.platformType);
    }

    // input for vision changed
    visionChanged(){
        this._profile.setWeakVision(this.userWeakVision);
    }
    
    // input for self efficiacy changed
    selfEfficiacyChanged(){
        this._profile.setComputerSelfEfficiacy(this.userSelfEfficiacy);
    }
    
    // input for environment brightness changed
    brightnessChanged(){
        this._profile.setBrightnessLevel(this.environmentBrightness);
    }

    //input for is admin changed
    isAdminChanged(){
        this._profile.setIsAdmin(this.isAdmin);
    }

    //input for is language changed
    isLanguageChanged(){
        this._profile.setLanguage(this.language);
    }
    
    logout() {
        this._service.logout();
    }
}