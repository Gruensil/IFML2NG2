package ifml.generator.ng2.m2t.general

import ifml.generator.ng2.core.FileManager

abstract class AbstractClassGenerator<T> extends AbstractCodeGenerator<T> {

	public override void generateCode(T it) {
		
		// Give subclasses the change to prepare for the generation effort
		prepareGeneration
		
		// Generate Component File
		FileManager::sharedInstance.generateFile(qualifiedName + ".ts",
			'''
				«generationJsHeader»
				
				«generateComponent»
			''');
		
		// Generate Template Files
		FileManager::sharedInstance.generateFile(qualifiedName + ".html",
			'''
				«generationHtmlHeader»
				
				«generateTemplate»
			''');
	}
	
	protected override def void prepareGeneration(T it){
	}
	
	protected abstract def String generateComponent(T it);

	protected abstract def String generateTemplate(T it);

}
