"use strict"

Thorax.LayoutView.extend(
    name: 'layout',
    trad: null,
    template: Handlebars.compile($('#layout').html()),
    popup: null
    isLogged: false

    el: '#app-container',

    events:
        'click .lingua': 'changeLanguage'
        'click .accedi': 'openLoginPopup'
        'click .popup-login': 'openLoginPopup'
        'click .logout': 'doLogout'
        'click .miei-eventi': 'openMieieventiPopup'
        'click .ricerca': 'openRicercaPopup'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.isLogged = window.app.UserInstance.get 'isLogged'

        this.listenTo this, 'rendered', () ->
            afterTimeout = () ->
                that.$el.addClass 'visible'
                $('#loader').removeClass 'open'

            that.$el.find('.lingua[data-value="' + Translator.currentLang + '"]').addClass 'active'
            setTimeout afterTimeout, 100

        this.listenTo window.app.UserInstance, 'sync', () ->
            that.isLogged = window.app.UserInstance.get 'isLogged'
            that.render()

    changeLanguage: (evt) ->
        that = this
        afterTimeout = () ->
            that.render()
            $('.main-menu a[href="' + location.pathname + '"').addClass 'active'
            $('#app-container').removeClass 'padded-top'

        evt.preventDefault()
        Translator.setLanguage $(evt.target).attr 'data-value'
        this.trad = Translator.getTranslations()

        $(document.body).scrollTo 0, {} =
            duration: 600

        $('#app-container').addClass 'padded-top'
        $('#app-container').removeClass 'visible'
        $('#loader').addClass 'open'
        setTimeout afterTimeout, 800

    openLoginPopup: (evt) ->
        evt.preventDefault()
        console.log 'ok'
        this.popup = new Thorax.Views['loginpopup']()
        this.popup.render()

        this.popup.$el.appendTo document.body

    openMieieventiPopup: (evt) ->
        evt.preventDefault()
        this.popup = new Thorax.Views['mieieventipopup'](
            eventi: app.UserInstance.get 'eventi'
        )

        this.popup.render()

        this.popup.$el.appendTo document.body

    openRicercaPopup: (evt) ->
        evt.preventDefault()
        this.popup = new Thorax.Views['ricercapopup']()

        this.popup.render()

        this.popup.$el.appendTo document.body

    doLogout: () ->
        $.ajax(
            url: '/api/logout'
            dataType: 'json'
            success: (resp) ->
                if resp.status == 'OK'
                    window.app.isLoggedUser = false
                    window.app.UserInstance.fetch()
                    Backbone.history.stop()
                    Backbone.history.start()
        )
)
