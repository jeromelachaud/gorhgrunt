Gorhplate
=========
a lot of dreams ... a lot of ideas ... a LOT of time lost buiding repetive task to start a project ...

simple grunt config and a common dir structure base files, that alow me to start new projects faster if you are looking for the next yeoman, pass your way :)



Grunt installation Notes
=========

[Grunt] is the tools used for compiling / scaffolding / concatenate / minify the css / js in the template, we used the 0.4 version so older version need to be uninstalled first (see installation process)

the [project] on github contains the packtage.json and gruntfile.coffe files needed to install the required dépendencies, and handle the scafolding process

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

change anything in the sass/js files save, grunt do the work ...

#### edit the configuration

to change the behavior of the grunt file, you need to edit the gruntfile.coffee file in the root of the project
see the [Grunt] website for configuration option (more to come here when I have time to write it)

## Plugins used

* Grunt : you can't grunt without grunt !!!
* Grunt-contrib-compass : sass > css, css concatenation, will minify for the prodversion
* Grunt-contrib-watch : fire the main grunt task on change on the sass/js files

  [project]: http://github.com/ityesnyou/HRTools
  [Grunt]: http://gruntjs.com/
  [node.js]: http://nodejs.org/