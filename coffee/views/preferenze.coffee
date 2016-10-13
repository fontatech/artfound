Thorax.View.extend(
    name: 'preferenzepopup'
    tagName: 'div'
    className: 'popup preferenze'
    template: Handlebars.compile($('#popup-preferenze').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click .labelpref': 'checkLabel'
        'click .salva-preferenze': 'salvaPreferenze'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()

        vWidth = app.getViewportWidth()

        if vWidth < 900
            top = document.body.scrollTop || document.documentElement.scrollTop
        else
            top = 0

        this.listenTo this, 'rendered', (evt) ->
            afterTimeout = () ->
                that.$el.find('.popup-inner').addClass 'open'

            that.$el.css 'top', top
            that.el.offsetLeft

            if this.conversazione
                this.$el.find('.labelpref[data-id="conversazioni"]').addClass 'checked'

            if this.inaugurazione
                this.$el.find('.labelpref[data-id="partecipazione"]').addClass 'checked'

            if this.notifiche
                this.$el.find('.labelpref[data-id="notifiche"]').addClass 'checked'

            if this.preferiti
                this.$el.find('.labelpref[data-id="preferiti"]').addClass 'checked'

            setTimeout afterTimeout, 50

    closePopup: (evt) ->
        that = this
        afterTimeout = () ->
            that.undelegateEvents()
            that.$el.removeData().unbind()
            that.remove()

        this.$el.find('.popup-inner').css 'opacity', '0'

        setTimeout afterTimeout, 300

    stopPropagation: (evt) ->
        evt.stopPropagation()

    checkLabel: (evt) ->
        evt.preventDefault()
        $(evt.target).toggleClass 'checked'

    getPreference: (key) ->
        label = this.$el.find '.labelpref[data-id="' + key + '"]'
        return label.hasClass 'checked'

    salvaPreferenze: (evt) ->
        evt.preventDefault()
        that = this

        preferences =
            inaugurazione: $('.labelpref[data-id="partecipazione"]').hasClass 'checked'
            conversazione: $('.labelpref[data-id="conversazioni"]').hasClass 'checked'
            notifiche: $('.labelpref[data-id="notifiche"]').hasClass 'checked'
            preferiti: $('.labelpref[data-id="preferiti"]').hasClass 'checked'

        $.ajax(
            url: '/api/preferences/' + this.permalink
            type: 'POST'
            dataType: 'json'
            data: preferences
            success: (resp) ->
                app.layout.popup.closePopup()
                that.listenToOnce(window.app.UserInstance, 'sync', () ->
                    Backbone.history.stop()
                    Backbone.history.start()
                )
                window.app.UserInstance.fetch()
        )
)
