package ifml.generator.ng2.core

import IFML.Core.IFMLAction
import IFML.Core.IFMLModel
import IFML.Core.ViewElement
import IFML.Extensions.IFMLWindow
import ifml.generator.ng2.m2t.dynamic.app.views.ViewContainerGenerator
import ifml.generator.ng2.m2t.boilerplate.index.IndexGenerator
import ifml.generator.ng2.m2t.boilerplate.npm.NpmPackageGenerator
import ifml.generator.ng2.m2t.dynamic.app.RoutesGenerator
import IFML.Core.impl.ViewContainerImpl
import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.services.NoolsServiceGenerator

class CodeGenerator {

	// Instance Methods
	def generateCode(IFMLModel ifmlModel, Document adaptModel) {

		// Extract relevant model elements 
		val appName = ifmlModel.name.toFirstUpper;
		val actions = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(IFMLAction));
		val viewElements = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(ViewElement));
		val windows = viewElements.filter(typeof(ViewContainerImpl));
		val viewComponents = windows.map[w|w.viewElements].flatten;
		
		// Dynamic Generation
		windows.forEach [ w |
			// ViewController
			new ViewContainerGenerator().generateCode(w)
		]
		// routes
		new RoutesGenerator().generateFile(windows);
		
		// Services
		new NoolsServiceGenerator().generateFile(adaptModel);
		
		// Boilerplate Generation
		// generate index.html
		new IndexGenerator().generateFile(appName);
		// generate package.json
		new NpmPackageGenerator().generateFile(appName);

	}
}
