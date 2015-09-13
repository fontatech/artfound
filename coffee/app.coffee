$( (evt) ->

    Translator.on('loaded', () ->
        app.layout = new Thorax.Views['layout']
        app.layout.render()

        router = new app.router()
    )

    Translator.init()

    $(window).on 'scroll', ->
        TweenLite.to $('#app-container'), 0.12, {} =
            y: -window.scrollY
            force3D: true

    $(document).on 'click', 'a:not([data-bypass])', (evt) ->
        evt.preventDefault()
        href = {} =
            prop: $(evt.target).prop("href")
            attr: $(evt.target).attr("href")

        Backbone.history.navigate href.attr, true
)
