package ifml.generator.ng2.m2t.dynamic.app.services

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import org.w3c.dom.Document
import java.util.HashMap

class NoolsServiceGenerator extends AbstractFileGenerator<Document> {
	
	// Overridden Parent methods
	override protected fileContents(Document doc) {
		var services = doc.firstChild.firstChild;
		var servicesChildList = services.childNodes;
		var serviceMap = new HashMap();
		var functionMap = new HashMap();
		
		if(servicesChildList != null && servicesChildList.length > 0){	
			for(var i = 0; i < servicesChildList.length; i++){
				serviceMap.put(servicesChildList.item(i).attributes.getNamedItem("id").nodeValue,servicesChildList.item(i).attributes.getNamedItem("type").nodeValue);
				var functionNodeList = servicesChildList.item(i).childNodes;
				var tempHash = new HashMap();
				for(var j = 0; j < functionNodeList.length; j++){
					tempHash.put(functionNodeList.item(j).attributes.getNamedItem("id").nodeValue, functionNodeList.item(j).attributes.getNamedItem("name").nodeValue);
				}
				functionMap.put(servicesChildList.item(i).attributes.getNamedItem("id").nodeValue, tempHash);
			}
		}
		
		
		var flow = services.nextSibling;
		var rules = services.childNodes;
		'''
			import {Injectable, DynamicComponentLoader, Injector} from '@angular/core';
			import { Router } from '@angular/router';

			import { Profile } from '../helper/profile';
			import { DisplayProperties } from '../helper/displayProperties';
			
			import { ResourceService } from './resource.service';
			import { LoggerService } from './logger.service';
			
			declare var nools: any;
			declare var $: any;
			
			@Injectable()
			export class NoolsService {
				
				private flow;
				
				constructor(
					private dcl: DynamicComponentLoader,
					private injector: Injector,
					private _Router: Router,
					private _logger: LoggerService,
					private _ResourceService: ResourceService){
					this.flow = nools.flow("«flow.attributes.getNamedItem("name").nodeValue»", function(flow){
						«new NoolsRuleGenerator().generateCode(flow.childNodes, serviceMap, functionMap)»
					});
				}
					
				public getSession(){
					return this.flow.getSession();
				}
			}
			
		'''
	}
	
	override protected fileName(Document doc) {
		'''nools.service.ts'''
	}
	
	override protected folderName(Document doc) {
		'''app/services/'''
	}
}
