package ifml.generator.ng2.m2t.general

import ifml.generator.ng2.core.FileManager

abstract class AbstractFileGenerator<T> extends AbstractGenerator <T>{
	
	public def generateFile(T it) {
		FileManager::sharedInstance.generateFile(qualifiedName, fileContents);
	}
	
	protected abstract def String fileContents(T it);
	
	

}
