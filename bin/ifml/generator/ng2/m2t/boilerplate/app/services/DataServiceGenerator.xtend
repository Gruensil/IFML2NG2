package ifml.generator.ng2.m2t.boilerplate.app.services

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class DataServiceGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		import { Injectable, OnInit } from '@angular/core';
		
		@Injectable()
		export class DataService {
		
		  	constructor(){
		    }
		    
		}
		'''
	}

	override protected fileName(String it) {
		
		'''data.service.ts'''
	}

	override protected folderName(String it) {
		// placed in root
		'''app/services/'''
	}

}
