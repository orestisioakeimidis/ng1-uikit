# Load requirements
gulp = require "gulp"
$ = do require "gulp-load-plugins"
runSequence = require "run-sequence"
bowerFiles = require "main-bower-files"

# Global variables
prefix = "app"
source = "src"
paths =
  scripts: "#{source}/scripts/**/*.coffee"
  partials: "#{source}/partials/**/*.html"
  images: "#{source}/images/**/*"
  index: "#{source}/index.html"

# Compile coffeescript files
gulp.task "scripts", ->
  gulp.src paths.scripts
    .pipe $.plumber()
    .pipe $.coffee()
    .pipe gulp.dest "#{prefix}/scripts"
    .pipe $.connect.reload()

# Copy partials
gulp.task "partials", ->
  gulp.src paths.partials
    .pipe $.plumber()
    .pipe gulp.dest "#{prefix}/partials"
    .pipe $.connect.reload()

# Copy images
gulp.task "images", ->
  gulp.src paths.images
    .pipe $.plumber()
    .pipe $.imagemin()
    .pipe gulp.dest "#{prefix}/images"
    .pipe $.connect.reload()

# Compile index and inject all required files
gulp.task "index", ->
  gulp.src paths.index
    .pipe $.plumber()
    .pipe $.inject(
      gulp.src bowerFiles(), read: no
    , {ignorePath: prefix, name: "bower"})
    .pipe $.inject(
      gulp.src ["#{prefix}/scripts/**/*.js"], read: no
    , ignorePath: prefix)
    .pipe gulp.dest prefix
    .pipe $.connect.reload()

# Compile source files
gulp.task "compile", (callback) ->
  runSequence ["scripts", "partials", "images"], "index", callback

# Watch for any changes in source files
gulp.task "watch", ->
  gulp.watch paths.scripts, ["scripts"]
  gulp.watch paths.partials, ["partials"]
  gulp.watch paths.images, ["images"]
  gulp.watch paths.index, ["index"]

# Launch server and open application in the default browser
gulp.task "serve", ["compile"], (callback) ->
  $.connect.server
    root: prefix
    livereload: yes
  runSequence ["watch"], callback

# Default task
gulp.task "default", ["serve"]
