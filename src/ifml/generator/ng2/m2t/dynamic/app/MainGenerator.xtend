package ifml.generator.ng2.m2t.dynamic.app

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.utils.ServiceCollection

class MainGenerator extends AbstractFileGenerator<Iterable<ViewContainerImpl>> {
	
	// Overridden Parent methods
	override protected fileContents(Iterable<ViewContainerImpl> it) {
		'''
		import { bootstrap }    from '@angular/platform-browser-dynamic';
		import { HTTP_PROVIDERS } from '@angular/http';
		
		import { AppComponent } from './app.component';
		import { APP_ROUTER_PROVIDERS } from './app.routes';
		
		import {provide, PLATFORM_DIRECTIVES} from '@angular/core';
		
		// Import generated Nools Service
		import { NoolsService } from './services/nools.service';
		
		// Service Imports
		«FOR service : ServiceCollection.sharedInstance.services»
		import { «service.name» } from '.«service.location»';
		«ENDFOR»

		bootstrap(AppComponent,[
		    APP_ROUTER_PROVIDERS,
		    HTTP_PROVIDERS,
		    NoolsService,
			«FOR service : ServiceCollection.sharedInstance.services BEFORE ',' SEPARATOR ','»
			«service.name»
			«ENDFOR»
		]);
		'''
	}
	
	override protected fileName(Iterable<ViewContainerImpl> it) {
		'''main.ts'''
	}
	
	override protected folderName(Iterable<ViewContainerImpl> it) {
		'''app/'''
	}
}
