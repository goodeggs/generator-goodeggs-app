unless describe?
  {specExec} = require 'goodeggs-spec-helpers/runner'
  specExec (specModule) -> ['gulp', 'spec:karma', "--file=#{specModule.filename}"]

require './index'
require 'goodeggs-spec-helpers/shared_helper'

