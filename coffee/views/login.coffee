Thorax.View.extend(
    name: 'loginpopup'
    tagName: 'div'
    className: 'popup login'
    template: Handlebars.compile($('#popup-login').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click .do-login': 'doLogin'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()

        this.listenTo this, 'rendered', (evt) ->
            afterTimeout = () ->
                that.$el.find('.popup-inner').addClass 'open'

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

    doLogin: (evt) ->
        that = this
        password = $('#password').val()
        user = $('#email').val()

        $.ajax(
            url: '/api/login'
            dataType: 'json'
            success: (resp) ->
                if resp.status == 'OK'
                    that.closePopup()
                    window.app.UserInstance.fetch()
                    Backbone.history.stop()
                    Backbone.history.start()
        )
)
