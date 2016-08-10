package ifml.generator.ng2.m2t.general

import ifml.generator.ng2.core.FileManager

abstract class AbstractProtocolGenerator<T> extends AbstractCodeGenerator<T> {

	public override void generateCode(T it) {

		// Give subclasses the chance to prepare for the generation effort
		prepareGeneration

		// Generate Protocol Header
		FileManager::sharedInstance.generateFile(qualifiedName + ".h",
			'''
				«generationHeader»
				
				«generateComponent»
			''');
	}
	
	protected override def void prepareGeneration(T it) {
		
	}
	
	protected abstract def String generateComponent(T it);

}
