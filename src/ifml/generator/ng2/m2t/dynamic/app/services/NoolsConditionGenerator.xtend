package ifml.generator.ng2.m2t.dynamic.app.services;

import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import org.w3c.dom.Node

public class NoolsConditionGenerator extends AbstractViewElementGenerator<Node>{
	
	override protected generateTemplate(Node conditions) {
		var output = ""
		var isFirst = true;
		
		if(conditions.hasChildNodes){
			var node = conditions.firstChild;
			
			if(!isFirst)
			{
				output += " || ";
			}
			
			if(node.nodeName == "conditionGroup"){
				var condGroup = node.childNodes;
				output += "(";
				for(var i = 0;i < condGroup.length; i++){
					output += condGroup.item(i).attributes.getNamedItem("fact").nodeValue + " " + condGroup.item(i).attributes.getNamedItem("operator").nodeValue + " ";
					if(condGroup.item(i).attributes.getNamedItem("type").nodeValue == "string"){
						output += "'" + condGroup.item(i).attributes.getNamedItem("value").nodeValue + "'";
					}else if(condGroup.item(i).attributes.getNamedItem("type").nodeValue == "boolean"){
						output += condGroup.item(i).attributes.getNamedItem("value").nodeValue;
					}
					if(i < condGroup.length-1){
						output += " && ";
					}
				}
				output += ""
				output += ")";
			}else{
				output += node.attributes.getNamedItem("fact").nodeValue + " " + node.attributes.getNamedItem("operator").nodeValue + " ";
				if(node.attributes.getNamedItem("type").nodeValue == "string"){
					output += "'" + node.attributes.getNamedItem("value").nodeValue + "'";
				}else if(node.attributes.getNamedItem("type").nodeValue == "boolean"){
					output += node.attributes.getNamedItem("value").nodeValue;
				}
			}
		}
		
		return output
	}
	
	override protected prepareGeneration(Node conditions) {
	}
	
}