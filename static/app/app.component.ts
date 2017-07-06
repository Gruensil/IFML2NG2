		import { ROUTER_DIRECTIVES }  from '@angular/router';
		import { Component } from '@angular/core';
		import { NgClass } from '@angular/common';
		
		import { NavigationComponent } from './dynamic/navigation.component'

		import { NoolsTestBarComponent } from './tests/noolstestBar'
		
		import { AuthenticationService } from './services/authentication.service';
		import { DisplayPropertiesService } from './services/displayProperties.service';
		
		import { ContextControllerService } from './context/contextController.service';
		
		@Component({
		  selector: 'my-app',
		  providers: [
				AuthenticationService
				,ContextControllerService
				],
		  template: `
				<noolstestbar></noolstestbar>
		    <div id="desktopViewContainter" class="container">
		      <div id="headerBar" [ngClass]="_displayPropertiesService.displayProperties.headerBarClass" class="row" style="margin-right:0px;padding-left:0px;padding-right:0px;">
		        <div class="col-md-12" style="width:100%; padding-left:0;padding-right:0px;">
		          <a href="\" class="btn btn-link"><img src="./resources/images/logo_transparent.png" alt="LibSoft" height="115" width="175"></a>
		        </div>
		        <div>
		        </div>
		      </div>
		      <div class="row" style="margin-right:0px;margin-left:0px;">
						<navigation-component [navItems]="_displayPropertiesService.displayProperties.navigation"></navigation-component>
						<div [ngClass]="_displayPropertiesService.displayProperties.routerOutletClass" style="margin-left:0;width:83.33332%">
							<router-outlet></router-outlet>
						</div>
		      </div>
		    </div>
		  `,
		  directives: [ROUTER_DIRECTIVES, NavigationComponent, NoolsTestBarComponent, NgClass]
		})
		
		export class AppComponent {
		
		    constructor( 
				private _service: AuthenticationService,
        
        //--> New ContextService          
        private _context: ContextControllerService,				
        
        //--> Old manual ContextService          
				//private profile: ProfileService,
          
				private _displayPropertiesService: DisplayPropertiesService){
			}
		}