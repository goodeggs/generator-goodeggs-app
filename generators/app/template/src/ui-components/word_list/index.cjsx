React = require 'react'
{connectToStores} = require 'fluxible/addons'
{loadAllWords} = require('domain/words').Actions

class WordList extends React.Component
  @propTypes:
    words: React.PropTypes.array.isRequired

  @contextTypes:
    executeAction: React.PropTypes.func.isRequired

  componentDidMount: ->
    setInterval =>
      @context.executeAction loadAllWords
    , 5000

  render: ->
    {words} = @props
    <ul className="words">
      {
        <li className="word" key={word._id}>{word.text}</li> for word in words
      }
    </ul>

WordList = connectToStores WordList, ['WordStore'], (stores) ->
  return {
    words: stores.WordStore.getAll()
  }

module.exports = WordList


