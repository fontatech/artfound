var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    compass = require('gulp-for-compass'),
    htmlmin = require('gulp-htmlmin'),
    concat  = require('gulp-concat'),
    uglify  = require('gulp-uglify'),
    devdir  = 'build',
    proddir = 'prod',
    vendorlib = './coffee/vendor/';

gulp.task('default', function () {
    gulp.src('./coffee/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('./' + devdir + '/js/'));

    gulp.src('./sass/*.scss')
        .pipe(compass({
            sassDir: './sass/',
            cssDir: './' + devdir + '/css/',
            outputStyle: 'compressed'
        }));

    gulp.src('./templates/**/*.html')
        .pipe(htmlmin({collapseWhitespace: true}))
        .pipe(gulp.dest('./' + devdir + '/'));

    gulp.src([
            vendorlib + 'jquery.min.js',
            vendorlib + 'jquery.scrollToTop.min.js',
            vendorlib + 'TweenMax.min.js',
            vendorlib + 'underscore-min.js',
            vendorlib + 'backbone-min.js',
            vendorlib + 'handlebars.min.js',
            vendorlib + 'thorax.min.js',
        ])
        .pipe(uglify())
        .pipe(concat('lib.js'))
        .pipe(gulp.dest('./' + devdir + '/js/'));
});

gulp.task('devel', function () {
    gulp.src('./coffee/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('./' + devdir + '/js/'));

    gulp.src('./sass/*.scss')
        .pipe(compass({
            sassDir: './sass/',
            cssDir: './' + devdir + '/css/',
            outputStyle: 'compressed'
        }));

    gulp.src('./templates/**/*.html')
        .pipe(htmlmin({collapseWhitespace: true}))
        .pipe(gulp.dest('./' + devdir + '/'));
});
