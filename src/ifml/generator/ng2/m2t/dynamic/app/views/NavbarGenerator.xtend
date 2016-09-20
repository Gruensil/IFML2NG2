package ifml.generator.ng2.m2t.dynamic.app.views;

import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.general.AbstractClassGenerator

class NavbarGenerator extends AbstractClassGenerator<ViewContainerImpl> {
	
	// Overridden Parent methods
	override protected prepareGeneration(ViewContainerImpl it) {
	}

	override protected generateComponent(ViewContainerImpl it) {
		'''
			// Angular Imports
			import { Component, Input, OnChanges, SimpleChange } from '@angular/core';
			import { RouterLink } from '@angular/router';

			// Service Imports
			import { ProfileService } from '../services/profile.service';
			import { ResourceService } from '../services/resource.service';
			
			@Component({
				selector: 'navigation-component',
				templateUrl: '«folderName»«fileName».html',
				providers: [ RouterLink ]
			})
			
			export class NavigationComponent implements OnChanges{
			    @Input() navItems: Object[] = [];
			
			    constructor(
			    	private profile: ProfileService, 
			    	private resources: ResourceService) {
			    }
			
			    ngOnChanges(changes: {[propKey: string]: SimpleChange}) {
			        for (let propName in changes) { 
			            let changedProp = changes[propName];
			        }
			    }
			}
		'''
	}

	override protected generateTemplate(ViewContainerImpl it) {
		'''
	        <nav [ngClass]="profile.getProfile().displayProperties.navbarContainerClass"> 
	          <div [ngClass]="profile.getProfile().displayProperties.navbarWrapperClass"> 
	            <div [ngClass]="profile.getProfile().displayProperties.navbarHeaderClass"> 
	              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-nav"> <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	                <span class="icon-bar"></span>
	              </button>
	              <a href="\" class="navbar-brand">LibSoft</a>
	            </div>
	            <div [ngClass]="profile.getProfile().displayProperties.navbarCollapseClass" id="bs-nav">
	              <ul [ngClass]="profile.getProfile().displayProperties.navbarItemListClass">
	                <li class="divLine borderSecondary" *ngFor="#entry of navItems">
	                  <a href="{{entry.path}}" class="textPrimary">{{resources.getLangString(entry.key)}}</a>
	                </li>
	              </ul>              
	            </div>
	          </div>
	        </nav>
		'''
	}

	override protected fileName(ViewContainerImpl it) {
		'''navigation.component'''
	}

	override protected folderName(ViewContainerImpl it) {
		"app/dynamic/"
	}

}
