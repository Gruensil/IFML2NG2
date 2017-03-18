package ifml.generator.ng2.m2t.dynamic.app.dynamic;

import IFML.Core.impl.ViewContainerImpl
import ifml.generator.ng2.m2t.general.AbstractClassGenerator
import ifml.generator.ng2.m2t.utils.ServiceCollection

class SearchComponentGenerator extends AbstractClassGenerator<ViewContainerImpl[]> {
	
	// Overridden Parent methods
	override protected prepareGeneration(ViewContainerImpl[] it) {
	}

	override protected generateComponent(ViewContainerImpl[] it) {
		'''
			// Angular Imports
			import { Component, Input, Output, OnChanges, EventEmitter, SimpleChange } from '@angular/core';

			// Service Imports
			«FOR service : ServiceCollection.sharedInstance.services»
			import { «service.name» } from '..«service.location»';
			«ENDFOR»
			
			@Component({
				selector: 'search-component',
				templateUrl: '«folderName»«fileName».html'
			})
			
			export class SearchComponent implements OnChanges{
			    @Input() searchSpace: Object[] = [];
			    public advancedFilter: Object = {};
			    @Input() title: string = "";
			
			    @Output() onFilterUpdate = new EventEmitter<Object>();
			    
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
			
			    updateFilterSimple(val: string){
			        this.onFilterUpdate.emit({'*':val});
			    }
			
			    updateFilterAdvanced(key: string, val:string){
			        if(val !== "" || val == undefined){
			            this.advancedFilter[key] = val;
			        }else{
			            delete this.advancedFilter[key];
			        }
			        this.onFilterUpdate.emit(this.advancedFilter);
			    }
			}
		'''
	}

	override protected generateTemplate(ViewContainerImpl[] it) {
		'''
	        <div class="searchContainer" >
	            <div id="advancedSearch" class="row" *ngIf="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.isAdvancedUser">
	                <form action="" class="form-inline" style="margin-bottom:5px;">
	                    <div class="form-group col-md-6" *ngFor="let field of searchSpace">
	                        <div class="input-group">
	                            <input #advancedBox type="text" name="field.key" class="form-control" placeholder="{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString(field.title)}}" (keyup)="updateFilterAdvanced(field.key, advancedBox.value)">
	                            <span class="input-group-addon glyphicon glyphicon-search" style="top:0;" aria-hidden="true"></span>
	                        </div>  
	                    </div>
	                </form>
	            </div>
	            <div id="simpleSearch" class="row" [ngClass]="_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.searchInputGroupClass" *ngIf="!_«ServiceCollection.sharedInstance.displayProperties.name.toFirstLower».displayProperties.isAdvancedUser" style="margin-bottom:5px;">
	                <input #simpleBox type="text" class="form-control" placeholder="{{_«ServiceCollection.sharedInstance.resource.name.toFirstLower».getLangString('search')}}" (keyup)="updateFilterSimple(simpleBox.value)">
	                <span class="input-group-addon glyphicon glyphicon-search" style="top:0;" aria-hidden="true"></span>
	            </div>  
	        </div>
		'''
	}

	override protected fileName(ViewContainerImpl[] it) {
		'''search.component'''
	}

	override protected folderName(ViewContainerImpl[] it) {
		"app/dynamic/"
	}

}
