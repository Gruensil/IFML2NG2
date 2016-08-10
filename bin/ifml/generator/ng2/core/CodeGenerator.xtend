package ifml.generator.ng2.core

import IFML.Core.IFMLAction
import IFML.Core.IFMLModel
import IFML.Core.ViewElement
import IFML.Extensions.IFMLWindow
import ifml.generator.ng2.m2t.dynamic.ViewContainerGenerator
import ifml.generator.ng2.m2t.boilerplate.app.AppComponentGenerator
import ifml.generator.ng2.m2t.boilerplate.app.MainGenerator
import ifml.generator.ng2.m2t.boilerplate.config.SystemJsConfigGenerator
import ifml.generator.ng2.m2t.boilerplate.config.TsConfigGenerator
import ifml.generator.ng2.m2t.boilerplate.config.TypingsGenerator
import ifml.generator.ng2.m2t.boilerplate.index.IndexGenerator
import ifml.generator.ng2.m2t.boilerplate.npm.NpmPackageGenerator
import ifml.generator.ng2.m2t.boilerplate.app.services.AuthenticationServiceGenerator
import ifml.generator.ng2.m2t.boilerplate.app.services.DataServiceGenerator

class CodeGenerator {

	// Instance Methods
	def generateCode(IFMLModel ifmlModel) {

		// Extract relevant model elements 
		val appName = ifmlModel.name.toFirstUpper;
		val actions = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(IFMLAction));
		val viewElements = ifmlModel.interactionFlowModel.interactionFlowModelElements.filter(typeof(ViewElement));
		val windows = viewElements.filter(typeof(IFMLWindow));
		val viewComponents = windows.map[w|w.viewElements].flatten;
		
		windows.forEach [ w |
			// ViewController
			new ViewContainerGenerator().generateCode(w)
		]
		
		// Boilerplate Generation
		// generate app.component.ts
		new AppComponentGenerator().generateFile(appName);
		// generate main.ts
		new MainGenerator().generateFile(appName);
		// generate system.js.config
		new SystemJsConfigGenerator().generateFile(appName);
		// generate tsconfig.json
		new TsConfigGenerator().generateFile(appName);
		// generate typings.json
		new TypingsGenerator().generateFile(appName);
		// generate index.html
		new IndexGenerator().generateFile(appName);
		// generate package.json
		new NpmPackageGenerator().generateFile(appName);
		// generate services
		new AuthenticationServiceGenerator().generateFile(appName);
		new DataServiceGenerator().generateFile(appName);

	}
}
