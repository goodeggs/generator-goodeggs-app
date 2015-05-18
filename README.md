# generator-goodeggs-app [![Build Status](https://secure.travis-ci.org/goodeggs/generator-goodeggs-app.png?branch=master)](https://travis-ci.org/goodeggs/generator-goodeggs-app)

[Yeoman](http://yeoman.io) generator for an application following Good Eggs conventions.


## Getting Started

You need Yeoman:
```
$ npm install -g yo
```

generator-goodeggs-app isn't published to NPM, since it's just for us.
You can download it from our private NPM if you're connected to it:

```
$ npm install -g generator-goodeggs-npm
```

Or you can just point at the URL instead:

```
$ npm install -g git+https://github.com/goodeggs/generator-goodeggs-app
```

Or even better, checkout and link the repo so you can quickly fix things that don't work right:
```
$ git clone https://github.com/goodeggs/generator-goodeggs-app.git
$ cd generator-goodeggs-app && npm link
```

Then you can start a new application with:
```
$ mkdir my_app
$ cd $_
$ yo goodeggs-app
```
