package ifml.generator.ng2.m2t.dynamic.app.helper;

import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import IFML.Core.impl.ViewElementImpl
import IFML.Extensions.impl.ListImpl
import IFML.Core.impl.VisualizationAttributeImpl
import IFML.Core.impl.UMLStructuralFeatureImpl
import org.eclipse.uml2.uml.StructuralFeature
import org.eclipse.uml2.uml.internal.impl.PrimitiveTypeImpl
import ifml.generator.ng2.m2t.utils.UMLReferenceResolver

class PipeGenerator extends AbstractFileGenerator<ListImpl> {
	

	override protected fileContents(ListImpl it) {
		var output = '''
			import { Pipe, PipeTransform } from '@angular/core';			
		'''
		
		output += '''
			@Pipe({name: '«it.name»Filter'})
			export class «it.name.toFirstUpper»Filter implements PipeTransform{
				transform(items: any[], filterBy: any): any {
					// filter items array, items which match and return true will be returned, items that don't math will be filtered out
					if(items != undefined){
						if(filterBy === undefined){
							// no filter defined, return items array unfiltered
							return items;
						}else{
							filterBy = JSON.parse(filterBy);
							if(filterBy['*'] != undefined){
								// if filterBy contains '*'-element, all columns are filtered by value
								«FOR attribute: (it as ListImpl).viewComponentParts.get(0).subViewComponentParts.toList() BEFORE 'return items.filter(item => ' SEPARATOR '||' AFTER ');'»
									«IF (((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).type instanceof PrimitiveTypeImpl»
										item.«(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature as StructuralFeature).name».toString().toLowerCase().indexOf(filterBy['*'].toLowerCase()) !== -1
									«ELSE»
										«FOR ref : UMLReferenceResolver::sharedInstance.getOwnedAttributesLong(((attribute as VisualizationAttributeImpl).featureConcept as UMLStructuralFeatureImpl).structuralFeature) SEPARATOR '||'»
											item.«ref».toString().toLowerCase().indexOf(filterBy['*'].toLowerCase()) !== -1
										«ENDFOR»
									«ENDIF»
								«ENDFOR»
							}else{
								// filter by keys in filterBy array
								var arrayOfKeys = Object.keys(filterBy);
								if(arrayOfKeys.length >= 1){
									var tempItems;
			                        return items.filter(function(val) {
			                            for(var i = 0; i < arrayOfKeys.length; i++){            
			                                var explodedString = arrayOfKeys[i].split('.');
			                                var v = val;
			                                for (var j = 0, l = explodedString.length; j<l; j++){
			                                    v = v[explodedString[j]];
			                                }
			                                console.log(filterBy[arrayOfKeys[i]]);
			                                if(v.toLowerCase().indexOf(filterBy[arrayOfKeys[i]].toLowerCase()) !== -1){
			                                    return true;
			                                }
			                            }
			                            return false;
			                        });
								}else{
									// illegal filterBy
									return items;
								}
							}
						}
					}
				}
			}
		'''
		
		return output;
	}
	
	override protected fileName(ListImpl it) {
		'''«it.name».pipe.ts'''
	}

	override protected folderName(ListImpl it) {
		"app/helper/pipes/"
	}
}
