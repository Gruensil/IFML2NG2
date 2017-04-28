package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import org.w3c.dom.Document
import java.util.LinkedList

class ContextServiceGenerator extends AbstractFileGenerator<Document> {

	
// Overridden Parent methods
	override protected fileContents(Document doc) {
		var contextModel = doc.firstChild.firstChild;
	
		var entities = new LinkedList();
		var e = contextModel.firstChild;
		
		while(e.nodeName == "entity"){
			entities.add(e);
			e = e.nextSibling;			
		}

		var providers = e;
		var providersList = new LinkedList();	
				
		for(var i = 0; i < providers.childNodes.length; i++){
			providersList.add(i, providers.childNodes.item(i).attributes.getNamedItem("name").nodeValue);
		}
				
		'''
			import { Injectable} from '@angular/core';
			import { Subscription } from 'rxjs/Subscription';
			import { Observable } from 'rxjs/Rx';
			import { Profile } from '../helper/profile';
			
			«FOR prov: providersList»
				import { «prov.toFirstUpper» } from './«prov.toFirstLower».service';
			«ENDFOR»	
			
			@Injectable()
			export class ContextService{
				
			    private profile: Profile;
			    
«««			    ADD INTITIALIZATION
			    
			    
			    
				private timeInit: number = 0;       //initialization for the Timer
				private timeFast: number = 5000;    //update Time for the Fast Update in ms
				private timeSlow: number = 100000;   //update Time for the Slow Update in ms
				
				
				constructor(
				
«««					ADD SUBSCRIPTIONS
				
				
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
				
				fast(){
«««					ADD CODE FOR FAST SERVICES
				}
				
			    slow(){
«««					ADD CODE FOR SLOW SERVICES
			    }
			    		
		'''
	}
	
	override protected fileName(Document doc) {
		'''context.service.ts'''
	}
	
	override protected folderName(Document doc) {
		'''app/context/'''
	}
}