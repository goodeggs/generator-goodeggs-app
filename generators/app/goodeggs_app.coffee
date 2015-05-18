fs = require 'fs'
path = require 'path'
yeoman = require 'yeoman-generator'
{spawn} = require 'child_process'

git = (args..., done) ->
  child = spawn 'git', args, stdio: 'inherit'
  child.on 'close', done

npm = (args..., done) ->
  child = spawn 'npm', args, stdio: 'inherit'
  child.on 'close', done

module.exports = class GoodeggsAppGenerator extends yeoman.generators.Base

  constructor: (args, options, config) ->
    super
    @sourceRoot path.join(__dirname, 'template')
    @basename = path.basename process.cwd()
    @_skipInstall = options['skip-install']

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

    @prompt prompts, (responses) =>
      @[k] = v for k, v of responses
      done()

  writing:
    files: ->
      @directory ''

  install:
    symlink: ->
      fs.symlink '.', @destinationPath('src/node_modules'), @async()

    git: ->
      return if @_skipInstall
      git 'init', @async()

    npm: ->
      return if @_skipInstall
      npm 'install', @async()

    npmShrinkwrap: ->
      return if @_skipInstall
      npm 'shrinkwrap', @async()

