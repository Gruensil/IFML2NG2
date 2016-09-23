package ifml.generator.ng2.m2t.dynamic.app.views

import IFML.Core.impl.ViewContainerImpl

public class AuthenticationInitGenerator {
	
	protected def String generateCode(ViewContainerImpl it){
		var output = '''
			«IF (!it.annotations.empty)»
				«FOR annotation: it.annotations»
					«IF annotation.text.contains("<<authenticationRequirement>>")»
						«FOR substr: annotation.text.replace("<<authenticationRequirement>>","").split("&&")»
							this._auth.checkPrivilegesIncludeOne([«FOR req : substr.split("\\|\\|") SEPARATOR ','»{role:'«req.replace("role==","").trim()»'}«ENDFOR»]);
						«ENDFOR»
					«ENDIF»
				«ENDFOR»
			«ENDIF»
		''';
		
		return output;
	}
}
