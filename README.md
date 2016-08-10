# IFML2NG2

IFML2NG2 is a model-2-text generator for generating Angular 2 web applications from IFML models. 
This project is work in progress.

## Packages
Package **core** contains classes for rudimentary tasks like loading of files and models, validation and controlling the generator. 
Package **m2t** contains subpackages with the transformation classes. **boilerplate** classes are files which are static and are the same for similar applications. **dynamic** classes are generated dynamically by the generator according to the IFML model.

## Usage
Runtime arguments are 'pathToIFMLFile' 'pathToTargetDirectory'.
**pathToIFMLFile** should be the file path of a valid IFML model. The file type should be '.ecore'.
**pathToTargetDirectory** should be the path to an existing directory. This will be the directory where the Angular 2 app will be generated to.