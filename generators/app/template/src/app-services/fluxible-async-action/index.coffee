
fluxibleAsyncAction = (baseEvent, opts={}, fn) ->

  [opts, fn] = [{}, opts] if !fn and typeof opts is 'function'

  failureEvent = switch typeof opts.failureEvent
    when 'string'
      opts.failureEvent
    when 'function'
      opts.failureEvent(baseEvent)
    else
      fluxibleAsyncAction.generators.failureEvent(baseEvent)

  successEvent = switch typeof opts.successEvent
    when 'string'
      opts.successEvent
    when 'function'
      opts.successEvent(baseEvent)
    else
      fluxibleAsyncAction.generators.successEvent(baseEvent)

  return (context, payload, done) ->
    context.dispatch baseEvent
    try
      fn(context, payload, (err, result) ->
        if err?
          context.dispatch failureEvent, err
        else
          context.dispatch successEvent, result
        done(err, result)
      )
    catch err
      setTimeout ->
        context.dispatch failureEvent, err
        done(err)
      , 0

fluxibleAsyncAction.generators =
  failureEvent: (baseEvent) ->
    "#{baseEvent}_FAILURE"
  successEvent: (baseEvent) ->
    "#{baseEvent}_SUCCESS"

module.exports = fluxibleAsyncAction

