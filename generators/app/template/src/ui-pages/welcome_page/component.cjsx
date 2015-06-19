React = require 'react'
{provideContext} = require 'fluxible/addons'
WordList = require 'ui-components/word_list'

class WelcomePage extends React.Component

  render: ->
    <div>
      <h1><%= basename %></h1>
      <WordList />
    </div>

WelcomePage = provideContext WelcomePage

module.exports = WelcomePage

