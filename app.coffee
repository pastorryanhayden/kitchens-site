axis         = require 'axis'
rupture      = require 'rupture'
sass         = require 'roots-sass'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
records      = require 'roots-records'
roots_config = require 'roots-config'
marked       = require 'marked'

sermon_api = 'https://api.airtable.com/v0/appMthTrHxhLTkNpM/Sermons?api_key=keyRTLlrVS02vC3Vx'
series_api = 'https://api.airtable.com/v0/appMthTrHxhLTkNpM/Series?api_key=keyRTLlrVS02vC3Vx'
blog_api   = 'https://api.airtable.com/v0/appsniK33ChdrWgyJ/Posts?api_key=keyRTLlrVS02vC3Vx'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    sass(files: "assets/css/app.scss", out: 'css/app.css', style: 'nested'),
    records(
      sermon_list:
          url: sermon_api,
          hook: (res) -> res.records,
      series_list:
          url: series_api,
          hook: (res) -> res.records,
      blog_list:
          url: blog_api,
          hook: (res) -> res.records,
        ),
    roots_config(sermon_url: sermon_api, series_url: series_api, blog_url: blog_api, static_items: 10, md: marked)
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
