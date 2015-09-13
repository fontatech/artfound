"use strict"

Thorax.LayoutView.extend(
    name: 'layout',
    trad: null,
    template: Handlebars.compile($('#layout').html()),

    el: '#app-container',

    events:
        'click .lingua': 'changeLanguage'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.listenTo this, 'rendered', () ->
            afterTimeout = () ->
                that.$el.addClass 'visible'
                $('#loader').removeClass 'open'

            that.$el.find('.lingua[data-value="' + Translator.currentLang + '"]').addClass 'active'
            setTimeout afterTimeout, 100

    changeLanguage: (evt) ->
        that = this
        afterTimeout = () ->
            that.render()
            $('.main-menu a[href="' + location.pathname + '"').addClass 'active'
            $('#app-container').removeClass 'padded-top'

        evt.preventDefault()
        Translator.setLanguage $(evt.target).attr 'data-value'
        this.trad = Translator.getTranslations()

        $('#app-container').addClass 'padded-top'
        $('#app-container').removeClass 'visible'
        $('#loader').addClass 'open'
        setTimeout afterTimeout, 800
)
