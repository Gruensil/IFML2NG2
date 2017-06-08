		import { Injectable } from '@angular/core';
		import { Router } from '@angular/router';
		
		import { ProfileService } from '../services/profile.service';

		export class User {
		  constructor(
		    public email: string,
		    public password: string,
		    public role: string,
		    public id: string,
		    public firstname: string,
		    public lastname: string) { }
		}
		
		var users = [
		  new User('admin','admin','staff', '', 'Admin', 'User'),
		  new User('hstahl','hstahl','student', '6701277', 'Hagen', 'Stahl'),
		  new User('rich','rich','student', '1231233', 'Richard', 'Roe')
		];
		
		declare var $: any;
		
		@Injectable()
		export class AuthenticationService {
		
		  public isLoggedIn: boolean;
		
		  constructor(
		    private _router: Router,
			private profile: ProfileService){
		      this.isLoggedIn = false;
		    }
		
		  logout() {
		    localStorage.removeItem('user');
		    this.isLoggedIn = false;
			this.profile.setUserRole(undefined);
		    this._router.navigate(['login']);
		  }
		
		  login(username, pw){
		    var authenticatedUser = users.find(u => u.email === username);
		    if (authenticatedUser && authenticatedUser.password === pw){
		      localStorage.setItem('user', JSON.stringify(authenticatedUser));
		      this._router.navigate(['login']);
		      this.isLoggedIn = true;
			  this.profile.setUserRole(authenticatedUser.role);
		      return true;
		    }
		    return false;
		  }
		
		  getName(){
		    if (localStorage.getItem('user') !== null){
		        return JSON.parse(localStorage.getItem("user")).firstname + " " + JSON.parse(localStorage.getItem('user')).lastname;
		    }
		  }
		
		  getId(){
		    if (localStorage.getItem('user') !== null){
		        return JSON.parse(localStorage.getItem("user")).id;
		    }
		  }
		
		  checkCredentials(){
		    if (localStorage.getItem('user') === null){
		        this._router.navigate(['login']);
		    }
		  }
		
		  checkStaffPrivileges(){
		    var user: User;
		    user = JSON.parse(localStorage.getItem('user'));
		    if (user === null){
		        this._router.navigate(['login']);
		    }else{
		      if(user.role !== "staff")
		      {
		        this._router.navigate(['/']);
		      }
		    }
		  }
		  
		  checkPrivilegesIncludeOne(roleArray){
			var user: User;
		    user = JSON.parse(localStorage.getItem('user'));
		    if (user === null){
		        this._router.navigate(['/login']);
		    }else{
				var result = $.grep(roleArray, function(e){ return e.role == user.role; });
				if (result.length == 0) {
					this._router.navigate(['/login']);
				}
			}
		  }	
		  
		  boolCheckPrivilegesIncludeOne(roleArray){
			var user: User;
		    user = JSON.parse(localStorage.getItem('user'));
		    if (user === null){
		        return false;
		    }else{
				var result = $.grep(roleArray, function(e){ return e.role == user.role; });
				if (result.length == 0) {
					return false;
				}else{
					return true;
				}
			}
		  }	
		  
		
		  isStaff(){
		    if (localStorage.getItem('user') !== null && JSON.parse(localStorage.getItem("user")).role === 'staff'){
		      return true;
		    }else{
		      return false;
		    }
		  }
		
		  isStudent(){
		    if (localStorage.getItem('user') !== null && JSON.parse(localStorage.getItem('user')).role === 'student'){
		      return true;
		    }else{
		      return false;
		    }
		  }
		}