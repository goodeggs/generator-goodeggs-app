require './spec_helper'
path = require 'path'
helpers = require('yeoman-generator').test
assert = require('yeoman-generator').assert

describe 'goodeggs-app generated files', ->

  describe 'with a description', ->
    {description} = {}

    before (done) ->
      description = "Makes delicious whipped cream in an instant!"
      @runGenerator {description}, done

    it 'creates expected files', (done) ->
      assert.file [
        '.editorconfig'
        '.gitignore'
        '.travis.yml'
      ]
      done()

    describe 'package.json', ->
      it 'includes package name matching parent directory', ->
        assert.fileContent 'package.json', /// "name":\s"#{@reposlug}" ///

      it 'includes supplied description', ->
        assert.fileContent 'package.json', /// "description":\s"#{description}" ///

      it 'flags the package as private', ->
        assert.fileContent 'package.json', /// "private":\strue ///

