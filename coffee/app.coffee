$( (evt) ->

    Translator.on('loaded', () ->
        app.UserInstance.once 'sync', () ->
            app.layout = new Thorax.Views['layout']
            app.layout.render()

            window.app.routerinstance = new app.router()

        app.UserInstance.fetch()
    )

    Translator.init()

    $(window).on 'scroll', ->
        TweenLite.to $('#app-container'), 0, {} =
            y: -window.pageYOffset
            force3D: true

    $(document).on 'click', 'a:not([data-bypass])', (evt) ->
        evt.preventDefault()
        href = {} =
            prop: $(this).prop("href")
            attr: $(this).attr("href")

        Backbone.history.navigate href.attr, true


    $(document).on 'keyup', (evt) ->
        if evt.keyCode == 27
            if $('.popup').length > 0
                app.layout.popup.closePopup()
)
