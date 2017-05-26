import { Component } from '@angular/core';
import { AuthenticationService } from '../services/authentication.service';
import { Profile } from '../context/profile/profile'
import { Subscription } from 'rxjs/Subscription';
import { ContextControllerService } from '../context/contextController.service';

@Component({
    selector: 'noolstestbar',
    template: `
        <div class="row container" >
            <div class="checkbox">
                <label><input type="checkbox" [(ngModel)]="active" (ngModelChange)="setActivation()" checked="true">Context Tracking</label>
                <label><input type="checkbox" [(ngModel)]="dashboard" checked="true">ToggleDashboard</label>
            </div>
        </div>
        <div class="row container" [hidden]="!dashboard">
            <h4>Movement: {{movement}}</h4>
            <h4>Mood: {{mood}}</h4>
            <h4>Age: {{age}}</h4>
            <h4>Location: {{location}}</h4>
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
    private mood;
    private age;
    private location;

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
        private _context : ContextControllerService
    ) {
        this.profile = this._context.getProfile();
        this.change = this._context.changedSubject.subscribe(change => {
		    this.movement = this.profile.getEnvironment().getMovement();
            this.mood = this.profile.getUser().getMood();
            this.age = this.profile.getUser().getAge();
            this.location = this.profile.getEnvironment().getLocation();

            this._context.setNotChanged();
		});
//            this.userWeakVision = _profile.getProfile().getUser().hasWeakVision();
//            this.userSelfEfficiacy = _profile.getProfile().getUser().hasHighComputerSelfEfficiacy();
//            this.isAdmin = _profile.getProfile().getUser().getIsAdmin();
//            this.language = _profile.getProfile().getUser().getLanguage();
//
//            this.platformType = _profile.getProfile().getPlatform().getPlatformType();
//
//            this.environmentBrightness = _profile.getProfile().getEnvironment().getBrightnessLevel();
        }

    logout() {
        this._service.logout();
    }
  
    setActivation(){
        this._context.setActivation(this.active);
    }
}