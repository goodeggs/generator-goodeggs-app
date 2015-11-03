require '../../server/modules/spec-helpers/node'

wordsService = require './words_service'

describe 'word service', ->

  it 'exports name', ->
    expect(wordsService).to.have.property 'name', 'words'

  describe 'read', ->
    beforeEach ->
      Factories.word.sync.createAndSave text: 'the bird'

    it 'returns words', ->
      words = wordsService.sync.read()
      expect(words).to.have.length 1
      expect(words[0]).to.have.property 'text', 'the bird'

