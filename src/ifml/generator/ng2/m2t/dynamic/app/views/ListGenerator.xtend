package ifml.generator.ng2.m2t.dynamic.app.views;

import IFML.Extensions.impl.ListImpl;
import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.impl.OnSelectEventImpl
import IFML.Core.impl.UMLStructuralFeatureImpl
import IFML.Core.impl.VisualizationAttributeImpl
import ifml.generator.ng2.m2t.utils.UMLReferenceResolver
import org.eclipse.uml2.uml.internal.impl.PropertyImpl
import org.eclipse.uml2.uml.StructuralFeature
import org.eclipse.uml2.uml.internal.impl.PrimitiveTypeImpl
import ifml.generator.ng2.m2t.utils.ServiceCollection

public class ListGenerator extends AbstractViewElementGenerator<ListImpl>{
	
	override protected generateTemplate(ListImpl listElement) {
		var output = "" 

		var dataBinding = listElement.viewComponentParts.get(0)
		var visualizationAttributes = dataBinding.subViewComponentParts.toList()
		 
		output += '''
			<div name="list" *ngIf="!_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.isMobile || (_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.isMobile && !selected«listElement.parameters.get(0).name.toFirstUpper»)">
        		<search-component [searchSpace]="advancedSearchSpace" [title]="'Search'" (onFilterUpdate)="filterUpdated($event)"></search-component>
				<table id="«listElement.id»" name="«listElement.name»" [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.tableClass">
					<thead>
		'''
		
		for(attribute : visualizationAttributes){
			output += '''
				«IF (((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).type instanceof PrimitiveTypeImpl»
						<th>
							{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('«(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).name»')}}
						</th>
				«ELSE»
					«FOR ref : UMLReferenceResolver::sharedInstance.getOwnedAttributesShort(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature)»
							<th>
								{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('«ref»')}}
							</th>
					«ENDFOR»
				«ENDIF»
			'''
		}
		
		output += '''
					</thead>
					<tbody>
		'''
		
		/*if(!listElement.viewElementEvents.isEmpty()) {
			var onSelectEvent = listElement.viewElementEvents.filter(OnSelectEventImpl).get(0)
			output += '''
				<tr *ngFor="let el of «dataBinding.name.toFirstLower»" (click)="«onSelectEvent.name»()">
			'''
		}else{*/
			output += '''
					<tr *ngFor="#el of «dataBinding.name.toFirstLower»| «listElement.name.toFirstLower»Filter: filterBy" (click)="onSelect(el)" [class.info]="el === selected«listElement.parameters.get(0).name.toFirstUpper»">
			'''
		//}
		
		for(attribute : visualizationAttributes){
			output += '''	
				«IF (((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).type instanceof PrimitiveTypeImpl»
					<td>
						{{el.«(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).name»}}
					</td>
				«ELSE»
					«FOR ref : UMLReferenceResolver::sharedInstance.getOwnedAttributesLong(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature)»
							<td>
								{{el.«ref»}}
							</td>
					«ENDFOR»
				«ENDIF»
			'''
		}			
		
		output += '''
						</tr>
					</tbody>
				</table>
			</div>
		'''
		//TODO only if no viewelement event with navigation flow!
		output += new MobileDetailsGenerator().generateTemplate(listElement)
		
		if(!listElement.viewElementEvents.isEmpty()) {
			
			for(onSelectEvent : listElement.viewElementEvents.filter(OnSelectEventImpl)){
				output += '''
					<button type="button" class="btn btn-default" (click)="«onSelectEvent.name»()" '''
				
				if(!onSelectEvent.annotations.isEmpty()){
					for(annotation : onSelectEvent.annotations){
						if(annotation.text.contains("<<activationExpression>")){
							var expr = annotation.text.replace("<<activationExpression>>","").trim();
							if(expr.contains("<<Parameter>>")){
								expr = expr.replace("<<Parameter>>","").trim();
								var pattern = "(=|>|<|>=|<|<=|<>|!=)";
								var operator = expr.replaceAll("[a-zA-Z]*", "").trim();
								var test = expr.split(pattern); 
								output += '''[ngClass]="{disabled: !isSelected«test.get(0).trim.toFirstUpper»}"'''
							}
						}
						if(annotation.text.contains("<<authenticationRequirement>")){
							for(substr: annotation.text.replace("<<authenticationRequirement>>","").split("&&")){
								output += '''*ngIf="_«ServiceCollection.sharedInstance.authentication.name.toFirstLower».boolCheckPrivilegesIncludeOne([«FOR req : substr.split("\\|\\|") SEPARATOR ','»{role:'«req.replace("role==","").trim()»'}«ENDFOR»])" '''
							}
						}
					}
				}
				
				output += '''>{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('«onSelectEvent.name»')}}</button>
				'''
			}
			
		}
		
		return output
	}
	
	override protected prepareGeneration(ListImpl it) {
	}
	
}