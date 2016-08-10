package ifml.generator.ng2.m2t.boilerplate.config

import ifml.generator.ng2.m2t.general.AbstractFileGenerator

class SystemJsConfigGenerator extends AbstractFileGenerator<String> {

	override protected fileContents(String it) {

		'''
		/**
		 * System configuration for Angular 2 samples
		 * Adjust as necessary for your application needs.
		 */
		(function(global) {
		  // map tells the System loader where to look for things
		  var map = {
		    'app':                        'app', // 'dist',
		    '@angular':                   'node_modules/@angular',
		    'angular2-in-memory-web-api': 'node_modules/angular2-in-memory-web-api',
		    'rxjs':                       'node_modules/rxjs',
		    'responsive-directives-angular2': 'node_modules/responsive-directives-angular2'
		  };
		  // packages tells the System loader how to load when no filename and/or no extension
		  var packages = {
		    'app':                        { main: 'main.js',  defaultExtension: 'js' },
		    'rxjs':                       { defaultExtension: 'js' },
		    'angular2-in-memory-web-api': { main: 'index.js', defaultExtension: 'js' },
		    'responsive-directives-angular2': { main: 'index.js', defaultExtension: 'js' },
		  };
		  var ngPackageNames = [
		    'common',
		    'compiler',
		    'core',
		    'forms',
		    'http',
		    'platform-browser',
		    'platform-browser-dynamic',
		    'router',
		    'router-deprecated',
		    'upgrade',
		  ];
		  // Individual files (~300 requests):
		  function packIndex(pkgName) {
		    packages['@angular/'+pkgName] = { main: 'index.js', defaultExtension: 'js' };
		  }
		  // Bundled (~40 requests):
		  function packUmd(pkgName) {
		    packages['@angular/'+pkgName] = { main: '/bundles/' + pkgName + '.umd.js', defaultExtension: 'js' };
		  }
		  // Most environments should use UMD; some (Karma) need the individual index files
		  var setPackageConfig = System.packageWithIndex ? packIndex : packUmd;
		  // Add package entries for angular packages
		  ngPackageNames.forEach(setPackageConfig);
		  var config = {
		    map: map,
		    packages: packages
		  };
		  System.config(config);
		})(this);
		'''
	}

	override protected fileName(String it) {
		
		'''systemjs.config.js'''
	}

	override protected folderName(String it) {
		// placed in root
		'''/'''
	}

}
