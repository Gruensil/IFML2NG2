package ifml.generator.ng2.core

import IFML.Core.IFMLAction
import IFML.Core.IFMLModel
import IFML.Core.ViewElement
import ifml.generator.ng2.m2t.dynamic.app.views.ViewContainerGenerator
import ifml.generator.ng2.m2t.boilerplate.index.IndexGenerator
import ifml.generator.ng2.m2t.boilerplate.npm.NpmPackageGenerator
import ifml.generator.ng2.m2t.dynamic.app.RoutesGenerator
import IFML.Core.impl.ViewContainerImpl
import org.w3c.dom.Document
import ifml.generator.ng2.m2t.dynamic.app.services.NoolsServiceGenerator
import org.eclipse.uml2.uml.Model
import ifml.generator.ng2.m2t.dynamic.app.data.ExportClassGenerator
import org.eclipse.uml2.uml.internal.impl.ClassImpl
import ifml.generator.ng2.m2t.dynamic.app.dynamic.NavbarGenerator
import ifml.generator.ng2.m2t.dynamic.app.dynamic.SearchComponentGenerator

class CodeGenerator {

	// Instance Methods
	def generateCode(IFMLModel ifmlModel, Model umlModel, Document adaptModel) {

		// Extract relevant model elements 
		val appName = ifmlModel.name.toFirstUpper;
		val actions = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(IFMLAction));
		val viewElements = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(ViewElement));
		val windows = viewElements.filter(typeof(ViewContainerImpl));
		val viewComponents = windows.map[w|w.viewElements].flatten;
		
		val classes = umlModel.allOwnedElements.filter(typeof(ClassImpl));
		
		// Dynamic Generation
		// Export Classes
		classes.forEach[ c |
			new ExportClassGenerator().generateFile(c);
		]
		// View Controller
		windows.forEach [ w |
			// ViewController
			new ViewContainerGenerator().generateCode(w);
			// Dynamic Components
			new NavbarGenerator().generateCode(w);
			new SearchComponentGenerator().generateCode(w);
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
