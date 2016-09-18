		import { bootstrap }    from '@angular/platform-browser-dynamic';
		import { HTTP_PROVIDERS } from '@angular/http';
		
		import { AppComponent } from './app.component';
		import { APP_ROUTER_PROVIDERS } from './app.routes';
		
		import {provide, PLATFORM_DIRECTIVES} from '@angular/core';
		
		import { NoolsService } from './services/nools.service';
		import { ProfileService } from './services/profile.service';
		import { ResourceService } from './services/resource.service';
		import { LoggerService } from './services/logger.service';

		bootstrap(AppComponent,[
		    APP_ROUTER_PROVIDERS,
		    HTTP_PROVIDERS,
			NoolsService,
			ProfileService,
			ResourceService,
			LoggerService
		]);