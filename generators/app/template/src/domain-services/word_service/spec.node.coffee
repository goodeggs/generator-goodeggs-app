require '../../server/modules/spec-helpers/node'

wordService = require './'

describe 'word service', ->

  it 'exports name', ->
    expect(wordService).to.have.property 'name', 'word_service'

  describe 'read', ->
    beforeEach ->
      Factories.word.sync.createAndSave text: 'the bird'

    it 'returns words', ->
      words = wordService.sync.read()
      expect(words).to.have.length 1
      expect(words[0]).to.have.property 'text', 'the bird'

