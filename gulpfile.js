var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    compass = require('gulp-for-compass'),
    htmlmin = require('gulp-htmlmin'),
    devdir  = 'build';

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
});
