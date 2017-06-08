import {Injectable, Input} from '@angular/core';

@Injectable()
export class LoggerService {

  constructor(){
  }

  public log(entry:string){
      console.log(entry);
  }

  public alert(message:string){
      console.log(message);
      window.alert(message);
  }

}