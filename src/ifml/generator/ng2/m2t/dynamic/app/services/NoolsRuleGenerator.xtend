package ifml.generator.ng2.m2t.dynamic.app.services;

import org.w3c.dom.NodeList
import java.util.HashMap

public class NoolsRuleGenerator{
	
	def protected generateCode(NodeList ruleNodeList, HashMap serviceMap, HashMap functionMap){
		return generateTemplate(ruleNodeList, serviceMap, functionMap);
	}
	
	def protected generateTemplate(NodeList ruleNodeList, HashMap serviceMap,  HashMap functionMap) {
		var output = ""
		
		if(ruleNodeList != null && ruleNodeList.length > 0){
			for(var i = 0; i < ruleNodeList.length; i++){
				var rule = ruleNodeList.item(i);
				var attr = rule.attributes;
				output += '''
					flow.rule("«attr.getNamedItem("name").nodeValue»", {salience:«attr.getNamedItem("priority").nodeValue»},[«attr.getNamedItem("factType").nodeValue»,"«attr.getNamedItem("factName").nodeValue»","«new NoolsConditionGenerator().generateCode(rule.firstChild)»"], function(facts){
						«new NoolsActionGenerator().generateCode(rule.firstChild.nextSibling.childNodes, serviceMap, functionMap)»
					});
				'''
			}
		}
		
		return output
	}
	
	def protected prepareGeneration(NodeList ruleNodeList, HashMap functionMap) {
	}
	
}