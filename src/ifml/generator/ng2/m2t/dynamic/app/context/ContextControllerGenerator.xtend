package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import org.w3c.dom.Document
import java.util.LinkedList

//helper class for creating a list with properties and its linked information, we can iterate easily
class PropertyInfo{
	public var propName = new String;
	public var propProv = new String;
	public var propEntity = new String;
	public var propUpdate = new String;
	
	new (String name, String entity, String prov, String update){
		this.propName = name;
		this.propProv = prov;
		this.propEntity = entity;
		this.propUpdate = update;
	}	
}

class ContextControllerGenerator extends AbstractFileGenerator<Document> {

	
// Overridden Parent methods
	override protected fileContents(Document adaptModel) {
		var contextModel = adaptModel.firstChild.firstChild;
	
//		extract the entities from the model
		var entities = new LinkedList();
		var e = contextModel.firstChild;
		
		while(e.nodeName == "entity"){
			entities.add(e);
			e = e.nextSibling;			
		}
		
//		create the providers list
		var providers = e;
		var providersList = new LinkedList();	
				
		for(var i = 0; i < providers.childNodes.length; i++){
			providersList.add(i, providers.childNodes.item(i).attributes.getNamedItem("name").nodeValue);
		}
		
//		extract the information from the properties
		var propertyList = new LinkedList()
		for(var j = 0; j < entities.size; j++){				
			var properties = entities.get(j).childNodes;				
			for(var k = 0; k < properties.length; k++){
				var entityName = entities.get(j).attributes.getNamedItem("name").nodeValue.toFirstLower;
				var propName = properties.item(k).attributes.getNamedItem("name").nodeValue.toFirstLower;
				var provName = properties.item(k).attributes.getNamedItem("provider").nodeValue.toFirstLower;
				var updateType = properties.item(k).attributes.getNamedItem("update").nodeValue;

				var property = new PropertyInfo(propName, entityName, provName, updateType);
				propertyList.add(property);
			}
		}	
		
				
		'''
			import { Injectable, Input } from '@angular/core';
			import { Subscription } from 'rxjs/Subscription';
			import { Observable } from 'rxjs/Rx';
			import { BehaviorSubject } from 'rxjs/Rx';
			import { Profile } from './profile/profile';
			
			import { DisplayProperties } from '../helper/displayProperties'
			
			import { NoolsService } from '../services/nools.service';
			
«««			Needed providers are imported
			«FOR prov: providersList»
				import { «prov.toFirstUpper»Service } from './providers/«prov.toFirstLower».service';
			«ENDFOR»	
			
			@Injectable()
			export class ContextControllerService{
				
			    private profile: Profile;
			    
			    private session: any;
			    
			    private active: boolean = true;
			    
			    private changed: boolean = false;
			    private _changedSubject: BehaviorSubject<boolean> = new BehaviorSubject(false);
			    public changedSubject: Observable<boolean> = this._changedSubject.asObservable();
			    
«««			    declare the subscriptions that are initiated later on
			    «FOR prop: propertyList»
			    private «prop.propName»: Subscription;
			    «ENDFOR»
			    
			    
			    
				private timeInit: number = 0;       //initialization for the Timer
				private timeFast: number = 5000;    //update Time for the Fast Update in ms
				private timeSlow: number = 100000;   //update Time for the Slow Update in ms
				
				
				constructor(
					private flow: NoolsService,
«««					Add the Providers
					«FOR prov: providersList SEPARATOR ","»
					private «prov.toFirstLower»Service: «prov.toFirstUpper»Service
					«ENDFOR»
				){
					
					this.profile = new Profile();
					this.flow.setProfile(this.profile);
					
					this.session = this.flow.getSession();
					
«««					Add subscriptions to subjects of providers
					«FOR prop: propertyList»
					this.«prop.propName» = this.«prop.propProv»Service.«prop.propName»Subject.subscribe(«prop.propName» => {
						if(this.active){
							this.profile.get«prop.propEntity.toFirstUpper»().set«prop.propName.toFirstUpper»(«prop.propName»);
							this.onModified();
						}
					});
					«ENDFOR»
				
					//Manager checks APIs fast
					let timerFast = Observable.timer(this.timeInit,this.timeFast);
					timerFast.subscribe(t => {
					    console.log(t);
					    this.fast();
					});
					
					//Manager checks APIs slow
					let timerSlow = Observable.timer(this.timeInit,this.timeSlow);
					timerSlow.subscribe(t => {
					    console.log(t);
					    this.slow();
					});
					
				}
				
«««				Properties that have fast update type are inserted here
				fast(){
					«FOR prop: propertyList»
						«IF prop.propUpdate == "fast"»
							this.«prop.propProv»Service.get«prop.propName.toFirstUpper»();
						«ENDIF»
					«ENDFOR»
				}
				
«««				Properties that have slow update type are inserted here
			    slow(){
					«FOR prop: propertyList»
						«IF prop.propUpdate == "slow"»
							this.«prop.propProv»Service.get«prop.propName.toFirstUpper»();
						«ENDIF»
					«ENDFOR»
			    }
			    
			    //returns Profile instance
				public getProfile(){
				    return this.profile;
				}
				
				public onModified(){
				  //now fire the rules
				  this.session.assert(this.getProfile());
				  this.session.match(function(err){
				      if(err){
				        console.error(err.stack);
				      }
				  });
				  this.changed = true;
				  this._changedSubject.next(this.changed);
				}
				
				public setActivation( status ){
					this.active = status;
				}
				
				public setNotChanged(){
					this.changed = false;
				}
			}
			
			
		'''
	}
	
	override protected fileName(Document adaptModel) {
		'''contextController.service.ts'''
	}
	
	override protected folderName(Document adaptModel) {
		'''app/context/'''
	}
}