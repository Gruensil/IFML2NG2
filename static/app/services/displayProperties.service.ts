import {Injectable, Input} from '@angular/core';

import { DisplayProperties } from '../helper/displayProperties'

@Injectable()
export class DisplayPropertiesService {

  public displayProperties: DisplayProperties;

  constructor(){
    // check if profile configuration ist already saved in local storage
    if(localStorage.getItem('displayProperties') != null){
      // parse profile configuration string to profile object
      var temp : any;
      temp = JSON.parse(localStorage.getItem('displayProperties'));
      //temp.state.__proto__ = StateProfile.prototype;
      temp.__proto__ = DisplayProperties.prototype;
      this.displayProperties = temp;
    }else{
      // initialize new profile configuration
      this.displayProperties = new DisplayProperties();

      // save profile configuration string to local storage
      localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
      this.displayProperties = new DisplayProperties();
    }
  }

  public getDisplayProperties(){
    return this.displayProperties;
  }    
  
  public setProperty(prop: string, v: any){
    this.displayProperties.setProperty(prop,v);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  public getProperty(prop){
    return this.displayProperties[prop];
  }

  public setType(v: string){
    this.displayProperties.setType(v);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  public setRole(v:string){
    this.displayProperties.setRole(v);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  public setTableClass(v:string){
    this.displayProperties.setTableClass(v);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  // set navigation for user
  public setNavigation(nav: Object[]){
    this.displayProperties.setNavigation(nav);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  // Get navigation for user
  public getNavigation(){
    this.displayProperties.getNavigation();
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  // clear navigation object
  public clearNavigation(){
    this.displayProperties.clearNavigation();
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  // push new Navigation item to navigation
  public pushNavigation(newItem:Object){
    this.displayProperties.pushNavigation(newItem);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

  // remove Navigation path from navigation
  public removeNavigationPath(path:String){
    this.displayProperties.removeNavigationPath(path);
    localStorage.setItem('displayProperties', JSON.stringify(this.displayProperties));
  }

}