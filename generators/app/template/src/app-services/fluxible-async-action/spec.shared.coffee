require '../../server/modules/spec-helpers/shared'

fluxibleAsyncAction = require './'

describe 'fluxibleAsyncAction', ->
  {action, context, resolver} = {}

  beforeEach ->
    context = @sinon.stub dispatch: (->)
    resolver = @sinon.stub()
    action = fluxibleAsyncAction 'FETCH', (context, payload, cb) ->
      resolver(cb)

  it 'dispatches base event on invocation', ->
    action context, {}, (->)
    expect(context.dispatch).to.have.been.calledWith 'FETCH'

  given 'success', ->

    beforeEach (done) ->
      resolver.yields(null, 'foo')
      action context, {}, done

    it 'dispatches success event', ->
      expect(context.dispatch).to.have.been.calledWith 'FETCH_SUCCESS', 'foo'

  given 'async failure', ->
    {err} = {}

    beforeEach (done) ->
      resolver.yields new Error('boom')
      action context, {}, (_err) ->
        err = _err
        done()

    it 'dispatches failure event', ->
      expect(context.dispatch).to.have.been.calledWith 'FETCH_FAILURE', err

    it 'resolves with error', ->
      expect(err).to.have.property 'message', 'boom'

  given 'sync failure', ->
    {err} = {}

    beforeEach (done) ->
      resolver.throws new Error('boom')
      action context, {}, (_err) ->
        err = _err
        done()

    it 'dispatches failure event', ->
      expect(context.dispatch).to.have.been.calledWith 'FETCH_FAILURE', err

    it 'resolves with error', ->
      expect(err).to.have.property 'message', 'boom'

