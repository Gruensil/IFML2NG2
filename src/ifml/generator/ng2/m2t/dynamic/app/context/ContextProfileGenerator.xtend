package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextEntityGenerator
import org.w3c.dom.Document
import java.util.LinkedList

class ContextProfileGenerator extends AbstractFileGenerator<Document> {

	
// Overridden Parent methods
	override protected fileContents(Document adaptModel) {
		
		var contextModel = adaptModel.firstChild.firstChild;
	
		var entities = new LinkedList();
		var e = contextModel.firstChild;
		
		while(e.nodeName == "entity"){
			entities.add(e);
			new ContextEntityGenerator().generateFile(e);
			e = e.nextSibling;			
		}
		
				
		'''
			«FOR entity: entities»
			«var entityName = entity.attributes.getNamedItem("name").nodeValue.toFirstUpper»
			import { «entityName»Profile } from './«entityName.toFirstLower».profile';
			«ENDFOR»
			
			export class Profile {
				
				«FOR entity: entities»
				«var entityName = entity.attributes.getNamedItem("name").nodeValue.toFirstUpper»
				public «entityName.toFirstLower»: «entityName»Profile;
				«ENDFOR»
			
			    constructor()
			    {
			       	// initialize context profiles			    	
				«FOR entity: entities»
				«var entityName = entity.attributes.getNamedItem("name").nodeValue.toFirstUpper»
					this.«entityName.toFirstLower» = new «entityName»Profile();
				«ENDFOR»
			    }
			    
			    «FOR entity: entities»
				«var entityName = entity.attributes.getNamedItem("name").nodeValue.toFirstUpper»
					// get «entityName» profile
					public get«entityName»() : «entityName»Profile{
						return this.«entityName.toFirstLower»;
					}
				«ENDFOR»
			}
		'''
	}
	
	override protected fileName(Document adaptModel) {
		'''profile.ts'''
	}
	
	override protected folderName(Document adaptModel) {
		'''app/context/profile/'''
	}
}