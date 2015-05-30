unless describe?
  {specExec} = require 'goodeggs-spec-helpers/runner'
  specExec (specModule) -> ['gulp', 'spec:node', "--file=#{specModule.filename}"]

require './index'
require 'goodeggs-spec-helpers/node_helper'

global.Factories = require './factories'
database = require './database'

# connect services (including the database)
before ->
  app = require '../../../app'
  app.sync.connect()

beforeEach ->
  database.sync.reset()

