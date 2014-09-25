var gulp = require("gulp"),
    gutil = require("gulp-util"),
    coffee = require("gulp-coffee"),
    coffeelint = require("gulp-coffeelint"),
    mocha = require("gulp-mocha");

gulp.task("coffee", function () {
  return gulp.src("./src/**/*.coffee")
    .pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest("./lib/"))    
});

gulp.task("coffee-test", function () {
  return gulp.src("./test/**/*.coffee")
    .pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest("./test"))    
});

gulp.task("lint", function () {
  return gulp.src(["./src/*.coffee", "./test/*.coffee"])
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
});

gulp.task("test", function () {
  return gulp.src("test/*.js")
    .pipe(mocha({reporter: "spec"}));
});

var tasks = ['lint', 'coffee', 'coffee-test', 'test'];

gulp.task("default", tasks, function () {
  return gulp.watch(["./src/**/*.coffee","./test/**/*.coffee"], tasks);
});