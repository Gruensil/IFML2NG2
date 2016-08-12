package ifml.generator.ng2.m2t.dynamic.views

import IFML.Extensions.IFMLWindow
import ifml.generator.ng2.m2t.general.AbstractClassGenerator

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
				
				//PLACEHOLDER DATA FOR TESTING
				public movieList = [{title:'Independence day',year:"1996"},{title:'Fight Club', year:'1999'}];
				
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
				<div class="col-md-2">
					<div class="sidebar-navbar">
						«new NavbarGenerator().generateCode(it)»
					</div>
				</div>
				<div class="col-md-10">
					<div name="content">
			 			«new ViewElementGenerator().generateCode(it.viewElements.toList)»
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
