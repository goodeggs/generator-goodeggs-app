path = require 'path'
helpers = require('yeoman-generator').test

before ->
  @reposlug = 'cuisinart' # prefix with node to test module name different from repo name
  @runGenerator = (prompts, done) ->
    helpers.run path.join(__dirname, '../generators/app')
      .inDir path.join(__dirname, 'generated', @reposlug)
      .withOptions
        'skip-install': true
        'quiet': true
      .withPrompts prompts
      .on 'end', done

