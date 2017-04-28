package ifml.generator.ng2.m2t.dynamic.app.context;

import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProvidersGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextServiceGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextProfileGenerator
import ifml.generator.ng2.m2t.dynamic.app.context.ContextTypesGenerator

class ContextManagerGenerator{
	
	def generateFile(Document adaptDSL){
		new ContextServiceGenerator().generateFile(adaptDSL);
		new ContextProvidersGenerator().generateFile(adaptDSL);
		new ContextTypesGenerator().generateFile(adaptDSL);
		//new ContextProfileGenerator().generateFile(adaptDSL);
	}	
	
}