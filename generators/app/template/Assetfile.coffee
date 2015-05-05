module.exports =

  css:
    entrypoints: 'src/ui-pages/*/index.styl'

  js:
    entrypoints: 'src/ui-pages/*/index.{coffee,cjsx}'

    externals:
      thirdparty:
        # modules that will be available to but excluded from the entrypoints
        require: [
          'lodash'
          'react'
          'fluxible'
          'fluxible/addons'
          'fluxible-plugin-fetchr'
          'keymirror'
        ]
        # prepend: same args as gulp.src
        # append: ditto

  dest:
    dev: 'public'
    prod: 'build/public'
    manifest: 'build/rev-manifest.json'

