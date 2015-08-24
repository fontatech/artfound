var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    compass = require('gulp-for-compass'),
    htmlmin = require('gulp-htmlmin');

gulp.task('default', function () {
    gulp.src('./js/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('./dest/'));

    gulp.src('./sass/*.scss')
        .pipe(compass({
            sassDir: './sass/',
            cssDir: './css/',
            outputStyle: 'compressed'
        }));

    gulp.src('./templates/**/*.html')
        .pipe(htmlmin({collapseWhitespace: true}))
        .pipe(gulp.dest('./html'));
});
