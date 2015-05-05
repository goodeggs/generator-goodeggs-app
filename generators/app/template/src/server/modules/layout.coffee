{renderable, doctype, html, head, title, meta, raw, body, script, link, div} = require 'teacup'
React = require 'react'

module.exports = renderable (locals, content) ->

  {assetPath, req} = locals

  doctype 5

  html ->
    head ->
      meta charset: 'utf-8'
      meta name: 'viewport', content: 'width=device-width, initial-scale=1, maximum-scale=1'
      raw content.head() if content.head?
      raw content.styles() if content.styles?
      link rel: 'stylesheet', href: assetPath("/build/css/#{content.component}.css") if content.component?
      title content.title?() or '<%= basename %>'

    body ->
      if content.body?
        raw content.body()

      if content.component?
        div '#jsx-root', ->
          component = require(content.component)
          raw React.renderToString(React.createFactory(component)(content.props))

      if content.page?
        {app, context} = content.page
        div '#jsx-root', ->
          raw React.renderToString(context.createElement())
        script "window.App = #{JSON.stringify(app.dehydrate(context))};"

      script src: assetPath('/build/js/ext/thirdparty.js')
      raw content.scripts() if content.scripts?

      if content.component?
        script src: assetPath("/build/js/#{content.component}.js")
        script """
          var React = require('react');
          var component = require(#{JSON.stringify(content.component)});
          var props = #{JSON.stringify(content.props)};
          var el = document.getElementById('jsx-root');
          var cb = (function(){}); // useful for events?
          React.render(React.createFactory(component)(props), el, cb);
        """

      if content.page?
        {requirePath} = content.page
        script src: assetPath("/build/js/#{requirePath}.js")
        script """
          var React = require('react');
          var app = require(#{JSON.stringify(requirePath)});
          var dehydratedState = window.App; // Sent from the server

          window.React = React; // chrome devtool support

          console.log('App rehydrating');
          app.rehydrate(dehydratedState, function (err, context) {
            if (err) { throw err; }
            console.log('App rehydrated');
            window.context = context;
            var mountNode = document.getElementById('jsx-root');
            console.log('React rendering');
            React.render(React.createFactory(app.getComponent())({context: context.getComponentContext()}), mountNode, function () {
              console.log('React rendered');
            });
          });
        """

