package ifml.generator.ng2.m2t.dynamic.app.services;

import org.w3c.dom.NodeList
import java.util.HashMap

public class NoolsActionGenerator{
	
	def generateCode(NodeList actionNodeList, HashMap serviceMap, HashMap functionMap){
		return generateTemplate(actionNodeList, serviceMap, functionMap);
	}
	
	def protected generateTemplate(NodeList actionNodeList, HashMap serviceMap, HashMap functionMap) {
		var output = ""
		
		if(actionNodeList != null && actionNodeList.length > 0){
			for(var i = 0; i < actionNodeList.length; i++){
				var action = actionNodeList.item(i);
				var attr = action.attributes;
				switch (action.nodeName) {
					case "editFactOperation": {
						if(attr.getNamedItem("set").nodeValue != null){
							output += '''
								facts.«attr.getNamedItem("set").nodeValue»;
							'''
						}
					}
					case "functionCall": {
						output += '''
							_«serviceMap.get(attr.getNamedItem("service").nodeValue)».«(functionMap.get(attr.getNamedItem("service").nodeValue) as HashMap).get(attr.getNamedItem("function").nodeValue)»("«attr.getNamedItem("value").nodeValue»");
						'''
					}
					case "deleteNavLinkOperation": {
						output += '''
							facts.«action.parentNode.parentNode.attributes.getNamedItem("factName").nodeValue».displayProperties.removeNavigationPath('/«attr.getNamedItem("viewContainer").nodeValue»');
						'''
					}
					case "addNavLinkOperation": {
						output += '''
							facts.«action.parentNode.parentNode.attributes.getNamedItem("factName").nodeValue».displayProperties.pushNavigation({path:'/«attr.getNamedItem("viewContainer").nodeValue»',key:'«attr.getNamedItem("langKey").nodeValue»'});
						'''
					}
					case "redirectOperation": {
						output += '''
							_Router.navigate(['/«attr.getNamedItem("viewContainer").nodeValue»']);
						'''
					}
					case "clearNavOperation": {
						output += '''
							facts.«action.parentNode.parentNode.attributes.getNamedItem("factName").nodeValue».displayProperties.clearNavigation();
						'''
					}
					case "editCssClassOperation": {
						output += '''
							$('.«attr.getNamedItem("cssClass").nodeValue»').css('«attr.getNamedItem("cssAttribute").nodeValue»','«attr.getNamedItem("value").nodeValue»');
						'''
					}
					case "setDisplayProperty": {
						if (attr.getNamedItem("type") == null || attr.getNamedItem("type").nodeValue == "string") {
							output += '''
								facts.«action.parentNode.parentNode.attributes.getNamedItem("factName").nodeValue».displayProperties.«attr.getNamedItem("property").nodeValue» = '«attr.getNamedItem("value").nodeValue»';
							'''
						}else{
							output += '''
								facts.«action.parentNode.parentNode.attributes.getNamedItem("factName").nodeValue».displayProperties.«attr.getNamedItem("property").nodeValue» = «attr.getNamedItem("value").nodeValue»;
							'''
						}
					}
					default: {
						output += "//unknown action: " + action.nodeName;	
						println("[WARNING] Unimplemented Action '" + action.nodeName + "' in Nools Service Generation");
					}
				}
			}
		}
		
		return output
	}
	
	def protected prepareGeneration(NodeList actionNodeList) {
	}
	
}