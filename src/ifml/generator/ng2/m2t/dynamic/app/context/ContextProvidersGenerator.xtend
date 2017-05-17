package ifml.generator.ng2.m2t.dynamic.app.context;

import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProviderGenerator
import java.util.LinkedList

class ContextProvidersGenerator{

	def generateFiles(Document adaptDSL){
		
		var contextModel = adaptDSL.firstChild.firstChild;
		
		var entities = new LinkedList();
		var e = contextModel.firstChild;
		
		//extract Entities
		while(e.nodeName == "entity"){
			entities.add(e);
			e = e.nextSibling;			
		}
		
		var providers = e;
		
		//Start a new FileGenerator for each Provider
		for(var i = 0; i < providers.childNodes.length; i++){
			
			var providerName = providers.childNodes.item(i).attributes.getNamedItem("name").nodeValue;
			var propertyList = new LinkedList;
			
			//Extract Properties that use that Provider
			for(var j = 0; j < entities.size; j++){				
				var properties = entities.get(j).childNodes;				
				for(var k = 0; k < properties.length; k++){
					var property = properties.item(k).attributes;
					if(property.getNamedItem("provider").nodeValue == providerName){
						propertyList.add(property);
					}
				}
			}			
			
			new ContextProviderGenerator().generateFiles(providerName, propertyList);
		}
		
	}
}