package ifml.generator.ng2.m2t.dynamic.app

import IFML.Extensions.IFMLWindow

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import IFML.Core.impl.ViewContainerImpl

class RoutesGenerator extends AbstractFileGenerator<Iterable<ViewContainerImpl>> {
	
	// Overridden Parent methods
	override protected fileContents(Iterable<ViewContainerImpl> it) {
		'''
			import { provideRouter, RouterConfig }  from '@angular/router';
			
			«it.map['''import { «name.toFirstUpper»Component } from './views/«name.toFirstLower».component';'''].join("\n")»

			export const routes: RouterConfig = [
				«it.map['''{
	path: '«name.toFirstLower»',
	component: «it.name.toFirstUpper»Component
},'''].join("\n")»
				{
					path: '',
					redirectTo: '/«it.findFirst[isDefault==true].name.toFirstLower»',
					pathMatch: 'full'
				}
			];
			
			export const APP_ROUTER_PROVIDERS = [
				provideRouter(routes)
			];
		'''
	}
	
	override protected fileName(Iterable<ViewContainerImpl> it) {
		'''app.routes.ts'''
	}
	
	override protected folderName(Iterable<ViewContainerImpl> it) {
		'''app/'''
	}
}
