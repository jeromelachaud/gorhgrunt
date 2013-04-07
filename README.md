gorhgrunt
=========

base gruntfile for my projects quickstart

Grunt installation Notes
=========

[Grunt] is the tools used for compiling / scaffolding / concatenate / minify the css / js for this template, I used the 0.4 version so older version need to be uninstalled first (see installation process)

the project contains the packtage.json and gruntfile.coffee files needed to install the required dépendencies, and handle the build process

## Installation
#### 1. prerquisites
grunt need node and npm installed to run you can get them here [node.js].
if you previously installed grunt, and are not using grunt > 0.4 you need to uninstall it first, you can do so with this command

```npm uninstall -g grunt```

#### 2. install the grunt-cli
This will put the grunt command in your system path, allowing it to be run from any directory.

```npm install -g grunt-cli```
You now have grunt-cli installed YAY :)

#### 3. install the dependencies
Install project dependencies with npm install.
```npm install```
you may need admin rights, if the install fail, ```sudo``` will do the trick

#### 4. Enjoy
You now are ready to use grunt and forget the hassle of merging all these css/js files

## Usage

#### tl;dr :

```cd projectDir```

```grunt watch```

change anything in the sass/js files, save, grunt do the work ...

#### edit the configuration

to change the behavior of the grunt file, you need to edit the gruntfile.coffee file in the root of the project
see the [Grunt] website for configuration option (more to come here when I have time to write it)

  [Grunt]: http://gruntjs.com/
  [node.js]: http://nodejs.org/
