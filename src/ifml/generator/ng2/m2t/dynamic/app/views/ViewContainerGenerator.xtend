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
import IFML.Core.impl.VisualizationAttributeImpl
import IFML.Core.impl.UMLStructuralFeatureImpl
import org.eclipse.uml2.uml.StructuralFeature
import org.eclipse.uml2.uml.internal.impl.PrimitiveTypeImpl

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
			
			«FOR vElem : it.viewElements»
				«IF (vElem instanceof ListImpl)»
					// Search Component Imports
					import { SearchComponent } from '../dynamic/search.component';
					import { «vElem.name.toFirstUpper»Filter } from '../helper/pipes/«vElem.name.toFirstLower».pipe';
				«ENDIF»
			«ENDFOR»

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
				directives: [NgClass «IF it.viewElements.exists[el|el instanceof ListImpl]»,SearchComponent«ENDIF» ],
				«FOR vElem : it.viewElements BEFORE 'pipes: [' SEPARATOR ',' AFTER ']'»«IF (vElem instanceof ListImpl)»«vElem.name.toFirstUpper»Filter«ENDIF»«ENDFOR»
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
						// variable for advanced search space
						advancedSearchSpace: Object;
						filterBy: String;
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
					private _profile: ProfileService){
					«FOR vElem : it.viewElements»
						«IF vElem instanceof ListImpl»
							// fill advanced search space
							this.advancedSearchSpace = [
							«FOR attribute: (vElem as ListImpl).viewComponentParts.get(0).subViewComponentParts.toList() SEPARATOR ','»
								«IF (((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).type instanceof PrimitiveTypeImpl»
										{key: "«(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).name»", title: "«attribute.name»"}
								«ELSE»
									«FOR ref : UMLReferenceResolver::sharedInstance.getOwnedAttributesLong(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature) SEPARATOR ','»
										{key: "«ref»", title: "«ref»"}
									«ENDFOR»
								«ENDIF»
							«ENDFOR»
							];
						«ENDIF»
					«ENDFOR»
				}
					
				// stubs generated for view element events
				«new ViewElementEventGenerator().generateCode(it.viewElements.toList)»
			
				«FOR vElem : it.viewElements»
					«IF (vElem instanceof ListImpl)»
						«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
							// stubs for data service calls for data bindings
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
						
						// called when search filter is updated
						filterUpdated(val: Object){
							this.filterBy = JSON.stringify(val);
						}
					«ENDIF»
				«ENDFOR»
				
				// called when component is initiated			
				ngOnInit(){
					// Check authentication requirements, if empty, no authentication requirements for this component
					«new AuthenticationInitGenerator().generateCode(it)»
					
					«FOR vElem : it.viewElements»
						«IF (vElem instanceof ListImpl)»
							// Call methods for filling data binding
							«FOR varCompPart : (vElem as ListImpl).viewComponentParts»
								this.get«(varCompPart as DataBindingImpl).name.toFirstUpper»();
							«ENDFOR»
						«ENDIF»
					«ENDFOR»
					
					«IF it.inInteractionFlows.size == 1 && it.inInteractionFlows.get(0).parameterBindingGroup != null»
						// Incoming Navigation Flows with Parameter Binding
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
			<div class="col-md-12">
				<div name="content">
	 	«new ViewElementGenerator().generateCode(it.viewElements.toList)»
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
