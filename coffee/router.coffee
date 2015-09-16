window.app = {}

window.app.router = Backbone.Router.extend(

    routes:
        '': 'main'
        'eventi': 'events'
        'about': 'about'
        'artisti': 'artisti'
        'artista/:artista': 'artista'
        'event/:evento': 'evento'

    initialize: () ->
        Backbone.history.start(
            pushState: true
        )

    transition: (newView, oldView, append, remove, complete) ->
        afterTimeout = () ->
            show = () ->
                $('#app-container').removeClass 'padded-top'
                $('#loader').removeClass 'open'
                newView.$el.addClass 'visible' if newView
            remove()
            complete()
            $(document.body).css 'height', $('#app-container').css 'height'
            $('.main-menu a[href="' + location.pathname + '"]').addClass 'active'

            setTimeout show, 100

        $(document.body).scrollTo 0, {} =
            duration: 600

        append()
        oldView.$el.removeClass 'visible' if oldView
        $('#app-container').addClass 'padded-top'
        $('#loader').addClass 'open'
        $('.main-menu a').removeClass 'active'

        setTimeout afterTimeout, 800

    main: () ->
        if !app.layout.getView()
            splash = new Thorax.Views['splashscreenview']()
            splash.render()

        app.layout.setView new Thorax.Views['index'](), {} =
            transition: this.transition

    events: () ->
        model =
            model: new app.EventsModel()

        app.layout.setView new Thorax.Views['events'](model), {} =
            transition: this.transition

    artisti: () ->
        app.layout.setView new Thorax.Views['artisti'](), {} =
            transition: this.transition

    about: () ->
        app.layout.setView new Thorax.Views['about'](), {} =
            transition: this.transition

    artista: (artista) ->
        model =
            model: new app.ArtistaModel({} =
                id: artista
            )

        app.layout.setView new Thorax.Views['artista'](model), {} =
            transition: this.transition

    evento: (evento) ->
        model =
            model: new app.EventoModel({} =
                id: evento
            )
            eventoId: evento

        app.layout.setView new Thorax.Views['evento'](model), {} =
            transition: this.transition
)
