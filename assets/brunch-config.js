exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        "before": ["css/normalize.css"],
        "after": ["css/app.sass"] // concat app.css last
      }
    },
    templates: { joinTo: "js/app.js" }
  },

  conventions: {
    assets: /^(static)/
  },
  paths: {
    watched: ["static", "css", "js", "vendor", "scss", "fonts"],
    public: "../priv/static"
  },
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    },
    sass: {
      mode: 'native',
      options: {
        includePaths: ["node_modules/font-awesome/scss"] // Tell sass-brunch where to look for files to @import
      }
    },
    copycat: {
      "fonts" : ["static/fonts", "node_modules/font-awesome/fonts"],
      verbose : false, //shows each file that is copied to the destination directory
      onlyChanged: true //only copy a file if it's modified time has changed (only effective when using brunch watch)
    }
  },
  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },
  npm: {
    enabled: true,
    globals: { // Bootstrap's JavaScript requires both '$' and 'jQuery' in global scope
      $: 'jquery',
      jQuery: 'jquery'
    }
  },
};
