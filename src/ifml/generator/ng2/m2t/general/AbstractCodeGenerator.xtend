package ifml.generator.ng2.m2t.general

import java.text.SimpleDateFormat
import java.util.Date

abstract class AbstractCodeGenerator <T> extends AbstractGenerator <T> {
	
	public abstract def void generateCode(T it);
	
	protected abstract def void prepareGeneration(T it);
	
	protected def String generationJsHeader() {
		
		'''
			//
			// Created by IFML2NG2 on «new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date)»
			//
		'''
	}
	
	protected def String generationHtmlHeader() {
		
		'''
			<!--
			   Created by IFML2NG2 on «new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date)»
			-->
		'''
	}		
}