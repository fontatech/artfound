$( (evt) ->

    #safari check
    ua = navigator.userAgent.toLowerCase()
    if ua.indexOf('safari') != -1
        if ua.indexOf('chrome') > -1
            isSafari = false
        else
            isSafari = true




    Translator.on('loaded', () ->
        app.UserInstance.once 'sync', () ->
            app.layout = new Thorax.Views['layout']
            app.layout.render()

            window.app.routerinstance = new app.router()

            app.initParallax()

        app.UserInstance.fetch()
    )

    app.loadHomeImages()
    Translator.init()

    $(document).on 'click', 'a:not([data-bypass])', (evt) ->
        evt.preventDefault()
        href = {} =
            prop: $(this).prop("href")
            attr: $(this).attr("href")

        $('.menumobi, .openmobi').removeClass 'open'

        Backbone.history.navigate href.attr, true


    $(document).on 'keyup', (evt) ->
        if evt.keyCode == 27
            if $('.popup').length > 0
                app.layout.popup.closePopup()
)
