Thorax.View.extend(
    name: 'index',
    tagName: 'div',
    className: 'view-class homepage',
    trad: null

    template: Handlebars.compile($('#homepage-layout').html())

    initialize: () ->
        this.trad = Translator.getTranslations()
        $('#home-rand-img').attr 'src', '/img/home/' + app.getRandImage()
)
