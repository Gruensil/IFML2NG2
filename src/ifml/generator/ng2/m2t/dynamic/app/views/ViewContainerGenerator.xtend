package ifml.generator.ng2.m2t.dynamic.app.views

import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import IFML.Core.impl.ViewContainerImpl
import IFML.Extensions.impl.ListImpl
import IFML.Core.impl.DataBindingImpl
import IFML.Core.impl.VisualizationAttributeImpl

class ViewContainerGenerator extends AbstractClassGenerator<ViewContainerImpl> {
	
	// Overridden Parent methods
	override protected prepareGeneration(ViewContainerImpl it) {
	}

	override protected generateComponent(ViewContainerImpl it) {
		'''
			// Angular Imports
			import { Component, OnInit } from '@angular/core';
			import { Router } from '@angular/router';

			// Service Imports
			import { DataService } from '../services/data.service';
			import { AuthenticationService } from '../services/authentication.service';
			import { ResourceService } from '../services/resource.service';
			
			@Component({
				selector: '«it.name.toFirstLower»',
				templateUrl: '«folderName»«fileName».html',
				providers: [DataService,AuthenticationService]
			})
			
			export class «it.name.toFirstUpper»Component {
				«FOR vElem : it.viewElements»
					«FOR vParam : vElem.parameters»
						var Selected«vParam.name.toFirstUpper»;
					«ENDFOR»
					«IF (vElem instanceof ListImpl)»
						«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
							«FOR vVisualization : (varCompPart as DataBindingImpl).subViewComponentParts»
								var «vVisualization.name»: «(vVisualization as VisualizationAttributeImpl).featureConcept»;
							«ENDFOR»
						«ENDFOR»
					«ENDIF»
				«ENDFOR»
				// PROTECTED REGION ID «it.id».«it.name» ENABLED START
				// PROTECTED REGION END
	
				constructor(
					private _data: DataService,
					private _auth: AuthenticationService,
					private _router: Router,
					private _resource: ResourceService){}
					
				//implement class here
				«new ViewElementEventGenerator().generateCode(it.viewElements.toList)»
			}
		'''
	}

	override protected generateTemplate(ViewContainerImpl it) {
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

	override protected fileName(ViewContainerImpl it) {
		'''«it.name.toFirstLower».component'''
	}

	override protected folderName(ViewContainerImpl it) {
		"app/views/"
	}

}