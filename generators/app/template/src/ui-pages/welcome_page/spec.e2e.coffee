require '../../server/modules/spec-helpers/e2e'
Word = require 'domain-models/word'

describe 'welcome', ->
  
  before ->
    Word.sync.remove()
    Word.sync.create text: 'the bird'

  it 'renders the word', ->
    @browser.sync.get '/'
    expect(@browser.sync.source()).to.contain 'the bird'

