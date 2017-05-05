package ifml.generator.ng2.m2t.dynamic.app

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.utils.ServiceCollection
import org.w3c.dom.Document
import java.util.LinkedList

class MainGenerator extends AbstractFileGenerator<Document> {
	
	// Overridden Parent methods
	override protected fileContents(Document adaptModel) {
		var providers = adaptModel.firstChild.firstChild.lastChild.previousSibling;
		var providersList = new LinkedList();
		
		for(var i = 0; i < providers.childNodes.length; i++){
			providersList.add(providers.childNodes.item(i).attributes.getNamedItem("name").nodeValue);
		}
		
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
		
		«FOR provider: providersList»
		import { «provider»Service } from './context/providers/«provider.toFirstLower».service';
		«ENDFOR»

		bootstrap(AppComponent,[
		    APP_ROUTER_PROVIDERS,
		    HTTP_PROVIDERS,
		    NoolsService,
			«FOR service : ServiceCollection.sharedInstance.services»
			«service.name»,
			«ENDFOR»
			
			«FOR provider: providersList»
			«provider.toFirstUpper»Service,
			«ENDFOR»
		]);
		'''
	}
	
	override protected fileName(Document adaptModel) {
		'''main.ts'''
	}
	
	override protected folderName(Document adaptModel) {
		'''app/'''
	}
}
