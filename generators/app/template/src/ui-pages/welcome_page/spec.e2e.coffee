require '../../server/modules/spec-helpers/e2e'

flow 'welcome', ->
  
  before ->
    Factories.word.sync.createAndSave
      text: 'the bird'

  it 'renders the word', ->
    @browser.sync.get '/'
    expect(@browser.sync.source()).to.contain 'the bird'

