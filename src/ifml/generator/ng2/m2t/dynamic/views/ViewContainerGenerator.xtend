package ifml.generator.ng2.m2t.dynamic

import IFML.Extensions.IFMLWindow
import IFML.Core.ViewComponent
import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import ifml.generator.ng2.m2t.utils.GeneratorHelpers
import ifml.generator.ng2.m2t.utils.MethodCollection

class ViewContainerGenerator extends AbstractClassGenerator<IFMLWindow> {
	
	// Overridden Parent methods
	override protected prepareGeneration(IFMLWindow it) {
	}

	override protected generateComponent(IFMLWindow it) {
		'''
			// Angular Imports
			import { Component, OnInit } from '@angular/core';
			import { Router } from '@angular/router';

			// Service Imports
			import { DataService } from '../services/data.service';
			import { AuthenticationService } from '../services/authentication.service';
			
			@Component({
				selector: '«it.name.toFirstLower»',
				templateUrl: '«fileName».html',
				providers: [DataService,AuthenticationService]
			})
			
			export class «it.name.toFirstUpper» {
				
				constructor(
					private _data: DataService,
					private _auth: AuthenticationService,
					private _router: Router){}
					
				//implement class here
				
			}
		'''
	}

	override protected generateTemplate(IFMLWindow it) {

		'''
			<div class="row">
				Test Template
			</div>
		'''
	}

	override protected fileName(IFMLWindow it) {
		'''«it.name.toFirstLower».component'''
	}

	override protected folderName(IFMLWindow it) {
		"app/views/"
	}

}
