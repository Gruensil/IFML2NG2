package ifml.generator.ng2.m2t.dynamic.app.services

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class TestGenerator extends AbstractFileGenerator<String>{
	
	override protected fileContents(String it) {
		'''Test content. «it»'''
	}
	
	override protected fileName(String it) {
		'''TestGenerator.ts'''
	}
	
	override protected folderName(String it) {
		'''app/services/'''
	}
	
}