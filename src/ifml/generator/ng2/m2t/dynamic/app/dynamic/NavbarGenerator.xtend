package ifml.generator.ng2.m2t.dynamic.app.dynamic;

import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import ifml.generator.ng2.m2t.utils.ServiceCollection

class NavbarGenerator extends AbstractClassGenerator<ViewContainerImpl[]> {
	
	// Overridden Parent methods
	override protected prepareGeneration(ViewContainerImpl[] it) {
	}

	override protected generateComponent(ViewContainerImpl[] it) {
		'''
			// Angular Imports
			import { Component, Input, OnChanges, SimpleChange } from '@angular/core';
			import { RouterLink } from '@angular/router';

			// Service Imports
			«FOR service : ServiceCollection.sharedInstance.services»
			import { «service.name» } from '..«service.location»';
			«ENDFOR»
			
			@Component({
				selector: 'navigation-component',
				templateUrl: '«folderName»«fileName».html',
				providers: [ RouterLink ]
			})
			
			export class NavigationComponent implements OnChanges{
			    @Input() navItems: Object[] = [];
			
			    constructor(
				«FOR service : ServiceCollection.sharedInstance.services SEPARATOR ','»
				private _«service.name.toFirstLower»: «service.name»
				«ENDFOR») {
			    }
			
			    ngOnChanges(changes: {[propKey: string]: SimpleChange}) {
			        for (let propName in changes) { 
			            let changedProp = changes[propName];
			        }
			    }
			}
		'''
	}

	override protected generateTemplate(ViewContainerImpl[] it) {
		'''
	        <nav [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.navbarContainerClass"> 
	          <div [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.navbarWrapperClass"> 
	            <div [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.navbarHeaderClass"> 
	              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-nav"> <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	              </button>
	              <a href="\" class="navbar-brand">LibSoft</a>
	            </div>
	            <div [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.navbarCollapseClass" id="bs-nav">
	              <ul [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.navbarItemListClass">
	                <li class="divLine borderSecondary" *ngFor="#entry of navItems">
	                  <a href="{{entry.path}}" class="textPrimary">{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString(entry.key)}}</a>
	                </li>
	              </ul>              
	            </div>
	          </div>
	          <div name="administrationControls" id="administrationControls">
	          	<button>Administration</button>
	          </div>
	        </nav>
		'''
	}

	override protected fileName(ViewContainerImpl[] it) {
		'''navigation.component'''
	}

	override protected folderName(ViewContainerImpl[] it) {
		"app/dynamic/"
	}

}
