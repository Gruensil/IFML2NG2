package ifml.generator.ng2.m2t.dynamic.app.views;

import ifml.generator.ng2.m2t.general.AbstractViewElementGenerator
import IFML.Extensions.impl.DetailsImpl

public class DetailsGenerator extends AbstractViewElementGenerator<DetailsImpl>{
	
	override protected generateTemplate(DetailsImpl listElement) {
		var output = ""
		
		var dataBinding = listElement.viewComponentParts.get(0)
		var visualizationAttributes = dataBinding.subViewComponentParts.toList()
		
		output += '''
			<table id="«listElement.id»" name="«listElement.name»" class="table table-bordered table-condensed">
		'''
		
		for(attribute : visualizationAttributes){
			output += '''
				<tr>
					<th>
						«attribute.name.toFirstUpper»
					</th>
					<td>
						{{«attribute.name»}}
					</td>
				</tr>
			'''
		}
		
		output += '''
			</table>
		'''

		return output
	}
	
	override protected prepareGeneration(DetailsImpl it) {
	}
	
}