package ifml.generator.ng2.m2t.dynamic.app.context;

import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProvidersGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextControllerGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProfileGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextTypesGenerator

class ContextServiceGenerator{
	
	def generateFiles(Document adaptModel){
		//Invoke the four parts of the Context Service Generator
		new ContextControllerGenerator().generateFile(adaptModel);
		new ContextProvidersGenerator().generateFiles(adaptModel);
		new ContextTypesGenerator().generateFiles(adaptModel);
		new ContextProfileGenerator().generateFile(adaptModel);
	}	
	
}