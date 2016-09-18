		import { ROUTER_DIRECTIVES }  from '@angular/router';
		import { Component } from '@angular/core';
		
		import {AuthenticationService} from './services/authentication.service';
		
		@Component({
		  selector: 'my-app',
		  providers: [AuthenticationService],
		  template: `
		    <div id="desktopViewContainter" class="container">
		      <div id="headerBar" class="row divLine" style="margin-right:0px;padding-left:0px;padding-right:0px;">
		        <div class="col-md-12" style="width:100%; padding-left:0;padding-right:0px; background-color:lightgray;">
		          <a href="\" class="btn btn-link"><img src="./resources/images/logo_transparent.png" alt="LibSoft" height="115" width="175"></a>
		        </div>
		        <div>
		        </div>
		      </div>
		      <div class="row">
		        <div class="col-md-12" style="margin-left:0;width:83.33332%">
		          <router-outlet></router-outlet>
		        </div>
		      </div>
		    </div>
		  `,
		  directives: [ROUTER_DIRECTIVES]
		})
		
		export class AppComponent {
		    public authService: AuthenticationService;
		
		    constructor( private _service: AuthenticationService ){
		          this.authService = _service;
		      }
		}