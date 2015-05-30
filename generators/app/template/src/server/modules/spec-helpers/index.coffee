
# semantic proxy. includes subs like `skip`.
class global.given extends global.describe
  constructor: (description, callback) ->
    description = "given #{description}"
    super description, callback

