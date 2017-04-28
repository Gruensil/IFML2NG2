package ifml.generator.ng2.m2t.dynamic.app.context;

import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.context.ContextTypeGenerator

class ContextTypesGenerator{

	def generateFile(Document adaptDSL){
		
		var contextModel = adaptDSL.firstChild.firstChild;
		
		var types = contextModel.lastChild.childNodes;
		for(var i = 0; i < types.length; i++){	
			new ContextTypeGenerator().generateFile(types.item(i));	
		}
	}
}