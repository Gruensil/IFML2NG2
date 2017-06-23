import { Component } from '@angular/core';
import { AuthenticationService } from '../services/authentication.service';
import { Profile } from '../context/profile/profile'
import { Subscription } from 'rxjs/Subscription';
import { ContextControllerService } from '../context/contextController.service';
import { Language } from '../context/types/Language';
import { Level } from '../context/types/Level';
import { DeviceType } from '../context/types/DeviceType';
import { Mood } from '../context/types/Mood';
import { Weather } from '../context/types/Weather';

@Component({
    selector: 'noolstestbar',
    template: `
        <div class="container" >
            <div class="checkbox">
                <label><input type="checkbox" [(ngModel)]="active" (ngModelChange)="setActivation()">Context Tracking</label>
                <label><input type="checkbox" [(ngModel)]="dashboard">ToggleDashboard</label>
                <a (click)="logout()" href="">Click Here to logout</a>
            </div>
        </div>
        <div class="container-fluid" [hidden]="!dashboard">
            <div class="row">
                <div class="col-md-3">
                    <table class="table table-striped">
                        <th><h3>User</h3></th>
                        <tr>
                            <td>Face Detected:</td>
                            <td>{{faceDetected}}</td> 
                        </tr>
                        <tr>
                            <td>Mood:</td>
                            <td>{{mood}}</td> 
                        </tr>
                        <tr>
                            <td>Age:</td>
                            <td>{{age}}</td> 
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td>{{gender}}</td> 
                        </tr>
                    </table>
                </div>
                <div class="col-md-3">
                    <table class="table table-striped">
                        <th><h3>Platform</h3></th>
                        <tr>
                            <td>Device Type:</td>
                            <td>{{deviceType}}</td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-3">
                    <table class="table table-striped">
                        <th><h3>Environment</h3></th>
                        <tr>
                            <td>Movement:</td>
                            <td>{{movement}}</td> 
                        </tr>
                        <tr>
                            <td>Location:</td>
                            <td>{{location}}</td> 
                        </tr>
                        <tr>
                            <td>Weather:</td>
                            <td>{{weather}}</td> 
                        </tr>
                    </table>
                </div>
                <div class="col-md-3">
                    <table class="table table-striped">
                        <th><h3>App</h3></th>
                        <tr>
                            <td>User Role:</td>
                            <td>{{userRole}}</td> 
                        </tr>
                        <tr>
                            <td>Mood Checked:</td>
                            <td>{{moodChecked}}</td> 
                        </tr>
                    </table>
                </div>
            </div>
            <!--<h4>AmbientLight: {{ambientLight}}</h4>-->
            <div id="affdex_elements" style="width:640px;height:480px;"></div>
        </div>
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
    private weather;
    private userRole;
    private moodChecked;

//    private userWeakVision: boolean;
//    private userSelfEfficiacy: string;

    constructor(
        private _service : AuthenticationService,
        private _context : ContextControllerService
    ) {
        this.active = true;
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
            this.weather = Weather[this.profile.getEnvironment().getWeather()];
            this.userRole = this.profile.getApp().getUserRole();
            this.moodChecked = this.profile.getApp().getMoodChecked();
            

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