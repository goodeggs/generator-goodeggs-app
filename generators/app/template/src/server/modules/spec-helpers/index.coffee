
unless describe?
  {specExec} = require 'goodeggs-spec-helpers/runner'
  specExec (specModule) -> ['gulp', 'spec', "--file=#{specModule.filename}"]

# semantic proxy. includes subs like `skip`.
class GLOBAL.given extends GLOBAL.describe
  constructor: (description, callback) ->
    description = "given #{description}"
    super description, callback

