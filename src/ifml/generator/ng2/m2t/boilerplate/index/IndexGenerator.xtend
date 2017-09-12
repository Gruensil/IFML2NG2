package ifml.generator.ng2.m2t.boilerplate.index

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class IndexGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		<html>
		  <head>
		    <base href="/">
		    <title>«it»</title>
		    <meta name="viewport" content="width=device-width, initial-scale=1">
		
		    
		    <script src="node_modules/jquery/dist/jquery.min.js"></script>
		    <script src="styles/bootstrap.min.js"></script>
		
		    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
		    <link rel="stylesheet" href="styles/styles.css">
		    <link rel="stylesheet" href="styles/sidebar.css">
		    <link rel="stylesheet" href="styles/navigation.css">
		    <link rel="stylesheet" href="styles/table.css">
		
		    <!-- 1. Load libraries -->
		     <!-- Polyfill(s) for older browsers -->
		    <script src="node_modules/core-js/client/shim.min.js"></script>
		    <script src="node_modules/zone.js/dist/zone.js"></script>
		    <script src="node_modules/reflect-metadata/Reflect.js"></script>
		    <script src="node_modules/systemjs/dist/system.src.js"></script>
			<script src="node_modules/nools/nools.js"></script>
			<script src="node_modules/mobile-detect/mobile-detect.js"></script>
		    
		
		    <!-- 2. Configure SystemJS -->
		    <script src="systemjs.config.js"></script>
		    <script>
		      System.import('app').catch(function(err){ console.error(err); });
		    </script>
		    
		  	<!-- 3. Add Provider API scripts -->
«««		  	This is the Protected Region the static index code for APIs is inserted (/static/index.html)
		  	<!-- PROTECTED REGION ID index ENABLED START -->
		  	<!-- PROTECTED REGION END -->
		    
		  </head>
		  

		
		  <!-- 4. Display the application -->
		  <body  class="textPrimary backgroundPrimary">
		  	<h3>«it»</h3>
		    <my-app></my-app>
		  </body>
		
		</html>
		'''
	}

	override protected fileName(String it) {
		
		'''index.html'''
	}

	override protected folderName(String it) {
		// placed in root
		'''/'''
	}

}
