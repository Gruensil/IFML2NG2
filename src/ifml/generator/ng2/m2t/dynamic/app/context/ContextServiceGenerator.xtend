package ifml.generator.ng2.m2t.dynamic.app.context;

import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProvidersGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextControllerGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProfileGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextTypesGenerator

class ContextServiceGenerator{
	
	def generateFile(Document adaptModel){
		new ContextControllerGenerator().generateFile(adaptModel);
		new ContextProvidersGenerator().generateFile(adaptModel);
		new ContextTypesGenerator().generateFile(adaptModel);
		new ContextProfileGenerator().generateFile(adaptModel);
	}	
	
}