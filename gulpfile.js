var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    compass = require('gulp-for-compass'),
    htmlmin = require('gulp-htmlmin'),
    concat  = require('gulp-concat'),
    uglify  = require('gulp-uglify'),
    watch = require('gulp-watch'),
    minifyHTML = require('gulp-minify-html'),
    htmlInclude = require('gulp-html-tag-include'),
    devdir  = 'build',
    proddir = 'prod',
    vendorlib = './coffee/vendor/';

var minifyOpts = {
    empty: true,
    conditionals: true,
    spare: true,
    quotes: true
};


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
        .pipe(htmlInclude())
        .pipe(minifyHTML(minifyOpts))
        .pipe(gulp.dest('./' + devdir + '/'));

    gulp.src([
            vendorlib + 'jquery.min.js',
            vendorlib + 'jquery.scrollToTop.min.js',
            vendorlib + 'TweenMax.min.js',
            vendorlib + 'underscore-min.js',
            vendorlib + 'backbone-min.js',
            vendorlib + 'handlebars.min.js',
            //vendorlib + 'thorax.min.js',
            vendorlib + 'thorax.js',
            vendorlib + 'jquery.mockjax.js',
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

    gulp.src('./templates/index.html')
        .pipe(htmlInclude())
        .pipe(minifyHTML(minifyOpts))
        .pipe(gulp.dest('./' + devdir + '/'));
});

gulp.task('look', function () {

    watch('./templates/**/*.html', function () {
        console.log('changed html');

        gulp.src('./templates/index.html')
            .pipe(htmlInclude())
            .pipe(minifyHTML(minifyOpts))
            .pipe(gulp.dest('./' + devdir + '/'));
    });

    watch('./sass/*.scss', function () {
        console.log('changed css');

        gulp.src('./sass/*.scss')
            .pipe(compass({
                sassDir: './sass/',
                cssDir: './' + devdir + '/css/',
                outputStyle: 'compressed'
            }));
    });

    watch('./coffee/**/*.coffee', function () {
        console.log('changed coffee');

        gulp.src('./coffee/**/*.coffee')
            .pipe(coffee())
            .pipe(gulp.dest('./' + devdir + '/js/'));

    });
});
