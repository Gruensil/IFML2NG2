package ifml.generator.ng2.m2t.dynamic.views

import IFML.Extensions.IFMLWindow
import IFML.Core.ViewComponent
import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import ifml.generator.ng2.m2t.utils.GeneratorHelpers
import ifml.generator.ng2.m2t.utils.MethodCollection
import IFML.Extensions.List
import IFML.Extensions.Details
import IFML.Extensions.impl.FormImpl
import IFML.Extensions.impl.DetailsImpl
import IFML.Extensions.impl.ListImpl

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
				templateUrl: '«folderName»«fileName».html',
				providers: [DataService,AuthenticationService]
			})
			
			export class «it.name.toFirstUpper»Component {
				
				constructor(
					private _data: DataService,
					private _auth: AuthenticationService,
					private _router: Router){}
					
				//implement class here
				
			}
		'''
	}

	override protected generateTemplate(IFMLWindow it) {
		val viewElements = it.viewElements.filter(typeof(ListImpl));
		'''
			<div class="row">
				<div class="col-md-12">
					<div name="content">
			 			«new ListGenerator().generateCode(viewElements)»
					</div>
				</div>
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
