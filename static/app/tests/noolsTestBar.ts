import { Component } from '@angular/core';
import { AuthenticationService } from '../services/authentication.service';
import { Profile } from '../context/profile/profile'
import { Subscription } from 'rxjs/Subscription';
import { ContextControllerService } from '../context/contextController.service';
import { Language } from '../context/types/Language';
import { Level } from '../context/types/Level';
import { DeviceType } from '../context/types/DeviceType';
import { Mood } from '../context/types/Mood';

@Component({
    selector: 'noolstestbar',
    template: `
        <div class="row container" >
            <div class="checkbox">
                <label><input type="checkbox" checked [(ngModel)]="active" (ngModelChange)="setActivation()">Context Tracking</label>
                <label><input type="checkbox" [(ngModel)]="dashboard">ToggleDashboard</label>
            </div>
        </div>
        <div class="row container" [hidden]="!dashboard">
            <h4>Movement: {{movement}}</h4>
            <h4>Face Detected: {{faceDetected}}</h4>
            <h4>Mood: {{mood}}</h4>
            <h4>Age: {{age}}</h4>
            <h4>Gender: {{gender}}</h4>
            <h4>Language: {{language}}</h4>
            <h4>Location: {{location}}</h4>
            <h4>Device Type: {{deviceType}}</h4>
            <h4>AmbientLight: {{ambientLight}}</h4>
            <div id="affdex_elements" style="width:640px;height:480px;"></div>
        </div>

        
        <a (click)="logout()" href="">Click Here to logout</a>
    	`
})

// class for testing nools by setting context attributes in a ui bar
export class NoolsTestBarComponent {
  
    private active: boolean;
    private dashboard: boolean;

    private profile: Profile;
    private change: Subscription;

    private movement;
    private faceDetected;
    private mood;
    private gender;
    private age;
    private location;
    private language;
    private deviceType;
    private ambientLight;

//    private userWeakVision: boolean;
//    private userSelfEfficiacy: string;

    constructor(
        private _service : AuthenticationService,
        private _context : ContextControllerService
    ) {
        this.profile = this._context.getProfile();
        this.change = this._context.changedSubject.subscribe(change => {
		    this.movement = Level[this.profile.getEnvironment().getMovement()];
            this.faceDetected = this.profile.getUser().getFaceDetected();
            this.mood = Mood[this.profile.getUser().getMood()];
            this.age = this.profile.getUser().getAge();
            this.gender = this.profile.getUser().getGender();
            this.language = Language[this.profile.getUser().getLanguage()];
            this.location = this.profile.getEnvironment().getLocation();
            this.deviceType = this.profile.getPlatform().getDeviceType();
            this.ambientLight = this.profile.getEnvironment().getAmbientLight();
            
            

            this._context.setNotChanged();
		});
//            this.userWeakVision = _profile.getProfile().getUser().hasWeakVision();
//            this.userSelfEfficiacy = _profile.getProfile().getUser().hasHighComputerSelfEfficiacy();
        }

    logout() {
        this._service.logout();
    }
  
    setActivation(){
        this._context.setActivation(this.active);
    }
}