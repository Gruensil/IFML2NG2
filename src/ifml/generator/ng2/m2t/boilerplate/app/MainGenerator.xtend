package ifml.generator.ng2.m2t.boilerplate.app

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class MainGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		import { bootstrap }    from '@angular/platform-browser-dynamic';
		import { HTTP_PROVIDERS } from '@angular/http';
		
		import { AppComponent } from './app.component';
		//import { APP_ROUTER_PROVIDERS } from './app.routes';
		
		import {provide, PLATFORM_DIRECTIVES} from '@angular/core';
		import { ResponsiveState, ResponsiveConfig, RESPONSIVE_DIRECTIVES } from 'responsive-directives-angular2';
		
		bootstrap(AppComponent,[
		//    APP_ROUTER_PROVIDERS,
		    HTTP_PROVIDERS,
		    ResponsiveState,
		    provide(PLATFORM_DIRECTIVES, { useValue: [RESPONSIVE_DIRECTIVES], multi: true})
		]);
		'''
	}

	override protected fileName(String it) {
		
		'''main.ts'''
	}

	override protected folderName(String it) {
		// placed in root
		'''app/'''
	}

}
