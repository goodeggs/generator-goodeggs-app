fs = require 'fs'
path = require 'path'
yeoman = require 'yeoman-generator'
{spawn} = require 'child_process'

git = (args..., done) ->
  child = spawn 'git', args, stdio: 'inherit'
  child.on 'close', done

module.exports = class GoodeggsAppGenerator extends yeoman.generators.Base

  constructor: (args, options, config) ->
    super
    @sourceRoot path.join(__dirname, 'template')
    @basename = path.basename process.cwd()

  prompting: ->
    done = @async()

    prompts = [
      {
        type: 'input'
        name: 'description'
        message: 'Describe your application'
        default: ''
      }
    ]

    @prompt prompts, ({@description}) -> done()

  writing:
    files: ->
      @directory ''

  install:
    symlink: ->
      done = @async()
      fs.symlink '.', @destinationPath('src/node_modules'), done

    git: ->
      done = @async()
      git 'init', done

    npm: ->
      @npmInstall()

