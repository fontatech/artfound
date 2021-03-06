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
        'click .register-open': 'openRegister'
        'click .do-registration': 'goRegister'
        'keyup #email': 'loginIf'
        'keyup #password': 'loginIf'

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
                that.startWithRegister() if that.isRegister

            that.$el.css 'top', top
            that.el.offsetLeft

            setTimeout afterTimeout, 50


    startWithRegister: () ->
        that = this
        this.$el.find('.step1').css 'display', 'none'
        this.$el.find('.step2').addClass 'fadein'


    closePopup: (evt) ->
        that = this

        if evt
            evt.stopPropagation()
            evt.preventDefault()

        afterTimeout = () ->
            that.undelegateEvents()
            that.$el.removeData().unbind()
            that.remove()

        this.$el.find('.popup-inner').css 'opacity', '0'

        setTimeout afterTimeout, 300

    stopPropagation: (evt) ->
        evt.stopPropagation()

    loginIf: (evt) ->
        this.doLogin() if evt.keyCode == 13

    doLogin: (evt) ->
        that = this
        password = $('#password').val()
        user = $('#email').val()

        $.ajax(
            url: '/api/login'
            dataType: 'json'
            type: 'POST'
            data: {} =
                email: user
                password: password
            success: (resp) ->
                afterTimeout = () ->
                    $('#email, #password').removeClass 'has-shake'

                afterTimeout2 = () ->
                    $('#email, #password').removeClass 'has-error'

                if resp.status == 'OK'
                    window.app.isLoggedUser = true
                    that.listenToOnce(window.app.UserInstance, 'sync', () ->
                        that.closePopup()
                        Backbone.history.stop()
                        Backbone.history.start()
                    )
                    window.app.UserInstance.fetch()
                else
                    $('#email,#password').addClass 'has-shake'
                    $('#email,#password').addClass 'has-error'
                    setTimeout afterTimeout, 600
                    setTimeout afterTimeout2, 3000
        )

    openRegister: (evt) ->
        that = this
        afterTimeout = () ->
            that.$el.find('.step1').css 'display', 'none'
            that.$el.find('.step2').addClass 'fadein'

        this.$el.find('.step1').addClass 'fadeout'
        setTimeout afterTimeout, 300

    goError: (selector) ->
        afterTimeout = () ->
            el.removeClass 'has-shake'
        afterTimeout2 = () ->
            el.removeClass 'has-error'

        el = $(selector)
        el.addClass 'has-shake'
        el.addClass 'has-error'

        setTimeout afterTimeout, 600
        setTimeout afterTimeout2, 3000

    goRegister: (evt) ->
        that     = this
        nome     = $('#nomecognome').val()
        email    = $('#emailreg').val()
        password = $('#passwordreg').val()
        regex    = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
        hasError = false

        $('#nomecognome,#emailreg,#passwordreg').removeClass 'has-shake'
        $('#nomecognome,#emailreg,#passwordreg').removeClass 'has-error'

        if nome.length < 3
            this.goError '#nomecognome'
            hasError = true

        if  !email or !regex.test email
            this.goError '#emailreg'
            hasError = true

        if password.length < 6
            this.goError '#passwordreg'
            hasError = true

        return false if hasError

        $.ajax(
            url: '/api/register'
            dataType: 'json'
            type: 'POST'
            data: {} =
                nome: nome
                email: email
                password: password
            success: (resp) ->
                if resp.status == 'KO'
                    that.goError '#emailreg'
                else
                    window.app.isLoggedUser = true
                    that.closePopup()
                    window.app.UserInstance.fetch()
                    Backbone.history.stop()
                    Backbone.history.start()
        )
)
