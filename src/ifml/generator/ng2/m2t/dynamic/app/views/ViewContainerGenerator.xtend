package ifml.generator.ng2.m2t.dynamic.app.views

import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import IFML.Core.impl.ViewContainerImpl
import IFML.Extensions.impl.ListImpl
import IFML.Core.impl.DataBindingImpl
import java.util.ArrayList
import IFML.Core.DomainConcept
import IFML.Core.IFMLModel
import IFML.Core.impl.InteractionFlowModelImpl
import org.eclipse.uml2.uml.internal.impl.ClassImpl
import ifml.generator.ng2.m2t.utils.UMLReferenceResolver

class ViewContainerGenerator extends AbstractClassGenerator<ViewContainerImpl> {
	
	ArrayList imports = new ArrayList();
	
	// Overridden Parent methods	
	override protected prepareGeneration(ViewContainerImpl it) {
	}

	override protected generateComponent(ViewContainerImpl it) {
		var header = '''
			// Angular Imports
			import { Component, OnInit } from '@angular/core';
			import { ActivatedRoute } from '@angular/router';
			import { Router } from '@angular/router';
			import { NgClass } from '@angular/common';

			// Service Imports
			import { DataService } from '../services/data.service';
			import { AuthenticationService } from '../services/authentication.service';
			import { ResourceService } from '../services/resource.service';
			import { ProfileService } from '../services/profile.service';
			
			'''
			
		var componentBody = '''
			@Component({
				selector: '«it.name.toFirstLower»',
				templateUrl: '«folderName»«fileName».html',
				providers: [DataService,AuthenticationService],
				directives: [NgClass]
			})
			
			export class «it.name.toFirstUpper»Component {
				//Generate variables for parameters and bindings
				«FOR vElem : it.viewElements»
					«FOR vParam : vElem.parameters»
						//TODO resolve reference to uml model
						selected«vParam.name.toFirstUpper»:  any;
						isSelected«vParam.name.toFirstUpper»:  boolean;
						«UMLReferenceResolver.sharedInstance.resolveProxyURI((vParam.type as ClassImpl).eProxyURI)»
					«ENDFOR»
					«IF (vElem instanceof ListImpl)»
						«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
							«IF (varCompPart instanceof DataBindingImpl)»
								// variable for list data binding
								«(varCompPart as DataBindingImpl).name.toFirstLower»: «IF ((varCompPart as DataBindingImpl).domainConcept != null)»«this.addImport(((varCompPart as DataBindingImpl).domainConcept))»«(varCompPart as DataBindingImpl).domainConcept.name»[]«ELSE»any«ENDIF»;
								«FOR vVisualization : (varCompPart as DataBindingImpl).subViewComponentParts»
									«vVisualization.name»: any;
								«ENDFOR»
							«ENDIF»
						«ENDFOR»
					«ENDIF»
				«ENDFOR»
				// PROTECTED REGION ID «it.id».«it.name» ENABLED START
				// PROTECTED REGION END

				constructor(
					private _data: DataService,
					private _auth: AuthenticationService,
					private _router: Router,
			    	private _route: ActivatedRoute,
					private _resource: ResourceService,
					private _profile: ProfileService){}
				// stubs generated for view element events
				«new ViewElementEventGenerator().generateCode(it.viewElements.toList)»
			
				// stubs for data service calls for data bindings
				«FOR vElem : it.viewElements»
					«IF (vElem instanceof ListImpl)»
						«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
							get«(varCompPart as DataBindingImpl).name.toFirstUpper»(){
								// PROTECTED REGION ID «varCompPart.id».get«varCompPart.name.toFirstUpper» ENABLED START
								// PROTECTED REGION END
							}
							
							onSelect(el: «(varCompPart as DataBindingImpl).domainConcept.name»){
								«FOR vParam : vElem.parameters»
									if(this.selected«vParam.name.toFirstUpper» === el){
										this.selected«vParam.name.toFirstUpper» = undefined;
										this.isSelected«vParam.name.toFirstUpper» = false;
									}else{
										this.selected«vParam.name.toFirstUpper» = el;
										this.isSelected«vParam.name.toFirstUpper» = true;
									}
								«ENDFOR»
							}
						«ENDFOR»
					«ENDIF»
				«ENDFOR»
							
				ngOnInit(){
					// Check authentication requirements, if empty, no authentication requirements for this component
					«new AuthenticationInitGenerator().generateCode(it)»
					
					«FOR vElem : it.viewElements»
						«IF (vElem instanceof ListImpl)»
							«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
								this.get«(varCompPart as DataBindingImpl).name.toFirstUpper»();
							«ENDFOR»
						«ENDIF»
					«ENDFOR»
					
					// Incoming Navigation Flows with Parameter Binding
					«IF it.inInteractionFlows.size == 1 && it.inInteractionFlows.get(0).parameterBindingGroup != null»
						this._route.params.subscribe(params => {
							this.selected«it.inInteractionFlows.get(0).parameterBindingGroup.parameterBindings.get(0).targetParameter.name.toFirstUpper» = JSON.parse(decodeURI(params['«it.inInteractionFlows.get(0).parameterBindingGroup.parameterBindings.get(0).targetParameter.name»']));
						});
					«ENDIF»
				}
			}
		'''
		
		header += '''
		// domain concept imports
		«FOR concept : this.imports»
					import { «(concept as DomainConcept).name.toFirstUpper» } from '../data/«(concept as DomainConcept).name.toFirstLower»';
		«ENDFOR»
		
		'''
		
		return header + componentBody;
	}
	
	def void addImport(DomainConcept umldc){
		imports.add(umldc);
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
