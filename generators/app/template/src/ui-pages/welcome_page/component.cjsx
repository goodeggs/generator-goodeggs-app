{PropTypes} = React = require 'react'
{connectToStores} = require 'fluxible/addons'

class WelcomePage extends React.Component
  @propTypes:
    words: PropTypes.array.isRequired

  render: ->
    {words} = @props
    <div>
      <h1><%= basename %></h1>
      <ul className="words">
        {
          <li className="word" key={word._id}>{word.text}</li> for word in words
        }
      </ul>
    </div>

WelcomePage = connectToStores WelcomePage, ['WordStore'], (stores) ->
  return {
    words: stores.WordStore.getAll()
  }

module.exports = WelcomePage

