		import {Injectable} from '@angular/core';
		import {Router} from '@angular/router';
		
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
		
		@Injectable()
		export class AuthenticationService {
		
		  public isLoggedIn: boolean;
		
		  constructor(
		    private _router: Router){
		      this.isLoggedIn = false;
		    }
		
		  logout() {
		    localStorage.removeItem('user');
		    this.isLoggedIn = false;
		    this._router.navigate(['login']);
		  }
		
		  login(user){
		    var authenticatedUser = users.find(u => u.email === user.email);
		    if (authenticatedUser && authenticatedUser.password === user.password){
		      localStorage.setItem('user', JSON.stringify(authenticatedUser));
		      this._router.navigate(['default']);
		      this.isLoggedIn = true;
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
		        this._router.navigate(['default']);
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