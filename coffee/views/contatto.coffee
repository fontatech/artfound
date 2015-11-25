Thorax.View.extend(
    name: 'contatto'
    tagName: 'div'
    className: 'view-class contatto'
    template: Handlebars.compile($('#contatto').html())
    timeline: null
    map: null

    events:
        'click .do-login': 'doLogin'
        'keyup #password-cont': 'loginIf'
        'keyup #email-cont': 'loginIf'
        'click .register-open': 'openRegister'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()
        this.isLogged = app.UserInstance.get 'isLogged'

        this._addChild this.timeline

        this.listenTo that, 'rendered', () ->
            afterTimeout = () ->
                that.createMap()

            that.timeline.render()
            that.$el.find('.timeline-container').html that.timeline.el
            setTimeout afterTimeout, 900


    createMap: () ->
        this.map = new google.maps.Map document.getElementById('map'), {} =
            center:
                lat: 45.472324
                lng: 9.203462
            scrollwheel: false
            zoom: 17
            disableDefaultUI: true


        marker = new MarkerWithLabel
            position:
                lat: 45.472324
                lng: 9.203462
            map: this.map
            labelContent: "Corso Venezia, 44"
            labelAnchor: new google.maps.Point(22, 0)
            labelClass: "labels"

    loginIf: (evt) ->
        this.doLogin() if evt.keyCode == 13

    doLogin: (evt) ->
        that = this
        password = $('#password-cont').val()
        user = $('#email-cont').val()

        $.ajax(
            url: '/api/login'
            dataType: 'json'
            type: 'POST'
            data: {} =
                email: user
                password: password
            success: (resp) ->
                afterTimeout = () ->
                    $('#email-cont, #password-cont').removeClass 'has-shake'

                afterTimeout2 = () ->
                    $('#email-cont, #password-cont').removeClass 'has-error'

                if resp.status == 'OK'
                    window.app.isLoggedUser = true
                    that.listenToOnce(window.app.UserInstance, 'sync', () ->
                        Backbone.history.stop()
                        Backbone.history.start()
                    )
                    window.app.UserInstance.fetch()
                else
                    $('#email-cont,#password-cont').addClass 'has-shake'
                    $('#email-cont,#password-cont').addClass 'has-error'
                    setTimeout afterTimeout, 600
                    setTimeout afterTimeout2, 3000
        )


    openRegister: (evt) ->
        evt.preventDefault()
        app.layout.popup = new Thorax.Views['loginpopup']({} =
            isRegister: true
        )
        app.layout.popup.render()

        app.layout.popup.$el.appendTo document.body
)

