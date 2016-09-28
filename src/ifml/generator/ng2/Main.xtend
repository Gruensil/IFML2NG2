package ifml.generator.ng2

import ifml.generator.ng2.core.ParametersValidator
import ifml.generator.ng2.core.FileManager
import ifml.generator.ng2.core.ModelLoader
import ifml.generator.ng2.core.ModelValidator
import ifml.generator.ng2.core.CodeGenerator
import ifml.generator.ng2.m2t.utils.UMLReferenceResolver

class Main {

	def static void main(String[] args){

		// whether the received parameters point to valid resources
		if(new ParametersValidator().validate(args)){
			
			// Prepare the File Manager & register input PATHS
			val fileManager = FileManager::sharedInstance
			fileManager.registerPathToOutputDirectory(args.get(4))
			val pathToAdaptFile = fileManager.registerPathToInputFile(args.get(2))
			val pathToUMLFile = fileManager.registerPathToInputFile(args.get(1))
			val pathToIFMLFile = fileManager.registerPathToInputFile(args.get(0))

			// Load the Models
			val modelLoader = new ModelLoader;
			val umlResolver = UMLReferenceResolver::sharedInstance
			val ifmlModel = modelLoader.loadIFMLModel(pathToIFMLFile)
			val umlDocument = modelLoader.loadAdaptModel("C:\\Users\\Hagen\\workspaceNeon\\IFML2NG2\\data\\test.xml")
			val umlModel = modelLoader.loadUMLModel(pathToUMLFile)
			val adaptModel = modelLoader.loadAdaptModel(args.get(2))
			umlResolver.UMLDocument = umlDocument
			umlResolver.UMLModel = umlModel
			
			
			
			// copy files
			fileManager.copyFiles(args.get(3), args.get(4))
			//var xsd = "C:\\Users\\STAH037\\workspace\\IFML2NG2\\data\\adapt.xsd";
			var xsd = "C:\\Users\\Hagen\\workspaceNeon\\IFML2NG2\\data\\adapt.xsd"
			// Whether the loaded IFML model can be transformed by the generation tool
			if(new ModelValidator().validate(ifmlModel) && new ModelValidator().validateAdaptFile(adaptModel, xsd)){
				
				new CodeGenerator().generateCode(ifmlModel, umlModel, adaptModel)
				println("M2T IFML2NG2 finished!")
				
			}

		}	
		
	}

}