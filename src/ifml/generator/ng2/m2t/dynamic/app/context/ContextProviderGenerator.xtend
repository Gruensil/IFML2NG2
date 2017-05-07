package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import java.util.LinkedList
import org.w3c.dom.NamedNodeMap

class Parameters{
	public var providerName = new String;
	public var propertyList = new LinkedList<NamedNodeMap>;	
	
	new (String prov, LinkedList<NamedNodeMap> list){
		providerName = prov;
		propertyList = list;
	}
}

class ContextProviderGenerator extends AbstractFileGenerator<Parameters> {
	
	def generateFiles(String providerName, LinkedList<NamedNodeMap> propertyList){
		var parameters = new Parameters(providerName, propertyList);
		
		this.generateFile(parameters);
	}
	
// Overridden Parent methods
	override protected fileContents(Parameters param) {
		
		var providerName = param.providerName;		
		var propertyList = param.propertyList;
		var typeList = new LinkedList;
		
		for(prop: propertyList){
			var propType = prop.getNamedItem("type").nodeValue.toFirstUpper;
			if(propType != "String" && propType != "Number" && propType != "Boolean" && !typeList.contains(propType)){
				typeList.add(propType);
			}
		}
				
		'''
			import { Injectable } from '@angular/core';
			import { Observable } from 'rxjs';
			import { BehaviorSubject } from 'rxjs/Rx';
			«FOR type: typeList»
				import { «type» } from '../types/«type»';
			«ENDFOR»
			
			@Injectable()
			export class «providerName.toFirstUpper»Service {
				
				«FOR prop: propertyList»
					«var propName = prop.getNamedItem("name").nodeValue.toFirstLower»
					«var propType = prop.getNamedItem("type").nodeValue.toFirstUpper»
«««					Fix FirstUpper/Lower!
					private «propName»: «propType»;
					private _«propName»Subject: BehaviorSubject<«propType»> = new BehaviorSubject(«IF propType=="String"»"init"«ELSEIF propType=="Boolean"»false«ELSE»0«ENDIF»);
					public «propName»Subject: Observable<«propType»> = this._«propName»Subject.asObservable();
				«ENDFOR»
				
				constructor(){
					
				}
				
				«FOR prop: propertyList»
					«var propName = prop.getNamedItem("name").nodeValue.toFirstLower»
					get«propName.toFirstUpper»(){
						this._«propName»Subject.next(this.«propName»);
					}
				«ENDFOR»
			}
		'''
	}
	
	override protected fileName(Parameters param) {		
		var providerName = param.providerName;
		
		'''«providerName.toFirstLower».service.ts'''
	}
	
	override protected folderName(Parameters param) {
		'''app/context/providers/'''
	}
}