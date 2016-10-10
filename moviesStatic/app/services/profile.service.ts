import {Injectable, Input} from '@angular/core';

import { Profile } from '../helper/profile'
import { DisplayProperties } from '../helper/displayProperties'

import { PlatformProfile } from '../helper/platform.profile';
import { UserProfile } from '../helper/user.profile';
import { StateProfile } from '../helper/state.profile';
import { EnvironmentProfile } from '../helper/environment.profile';

import { NoolsService } from '../services/nools.service';

declare var MobileDetect: any;

@Injectable()
export class ProfileService {

  private profile: Profile;
  private session: any;
  public md;

  constructor(
    private flow: NoolsService){
    // check if profile configuration ist already saved in local storage
    if(localStorage.getItem('profile') != null){
      // parse profile configuration string to profile object
      var temp : any;
      temp = JSON.parse(localStorage.getItem('profile'));
      temp.user.__proto__ = UserProfile.prototype;
      temp.environment.__proto__ = EnvironmentProfile.prototype;
      temp.platform.__proto__ = PlatformProfile.prototype;
      //temp.state.__proto__ = StateProfile.prototype;
      temp.displayProperties.__proto__ = DisplayProperties.prototype;
      temp.__proto__ = Profile.prototype;
      this.profile = temp;
      this.profile.state = new StateProfile();
    }else{
      // initialize new profile configuration
      this.profile = new Profile();
      
      this.md = new MobileDetect(window.navigator.userAgent);
      if(this.md.mobile() == null){
        this.profile.setPlatformType("desktop")
      }else{
        this.profile.setPlatformType("mobile");
      }

      // save profile configuration string to local storage
      localStorage.setItem('profile', this.profile.toJSON());
    }
    
    this.session = this.flow.getSession();
    this.onModified();
  }

  public setUserRole(v: string){
    this.profile.getUser().setUserRole(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setLanguage(v: string){
    this.profile.getUser().setLanguage(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setBrightnessLevel(v:number){
    this.profile.getEnvironment().setBrightnessLevel(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setComputerSelfEfficiacy(v: string){
    this.profile.getUser().setComputerSelfEfficiacy(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setWeakVision(v: boolean){
    this.profile.getUser().setWeakVision(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setIsAdmin(v: boolean){
    this.profile.getUser().setIsAdmin(v);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public setPlatformType(v: string){
    this.profile.getPlatform().setPlatformType(v);
    var test = JSON.stringify(this.profile);
    localStorage.setItem('profile', this.profile.toJSON());
    this.onModified();
  }

  public getProfile(){
    return this.profile;
  }

  public onModified(){
    //now fire the rules
    this.session.assert(this.getProfile());
    this.session.match(function(err){
        if(err){
            console.error(err.stack);
        }else{
            console.log("done");
        }
    });
  }
}