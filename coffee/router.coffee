window.app = {}

window.app.router = Backbone.Router.extend(

    routes:
        '': 'main'
        'eventi': 'events'
        'about': 'about'
        'artisti': 'artisti'
        'artista/:artista': 'artista'
        'event/:evento': 'evento'
        'pubblicazioni': 'pubblicazioni'
        'contatto': 'contatto'
        'contatto/:evento': 'contattoLink'
        'opere-proprietarie': 'opere'
        'ricerca/:query': 'ricerca'

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
            $('.main-menu a[href="' + location.pathname + '"]').addClass 'active'

            setTimeout show, 100

        $(document.body).scrollTo 0, {} =
            duration: 600

        append()
        oldView.$el.removeClass 'visible' if oldView
        $('#app-container').addClass 'padded-top'
        $('#loader').addClass 'open'
        $('.main-menu a').removeClass 'active'

        if app.isHome
            app._goToNonHome()

        setTimeout afterTimeout, 800

    homeTransition: (newView, oldView, append, remove, complete) ->
        afterTimeout = () ->
            show = () ->
                $('#app-container').removeClass 'padded-top'
                $('#loader').removeClass 'open'
                newView.$el.addClass 'visible' if newView
            remove()
            complete()
            $('#main-container').css 'height', '2240px'
            $('.main-menu a[href="' + location.pathname + '"]').addClass 'active'
            app._goToHomeLayout()

            setTimeout show, 100

        $(document.body).scrollTo 0, {} =
            duration: 600

        append()
        oldView.$el.removeClass 'visible' if oldView
        $('#app-container').addClass 'padded-top'
        $('#loader').addClass 'open'
        $('.main-menu a').removeClass 'active'

        #Footer restyle (change for responsive)
        $('footer .inner').css 'margin-left', '261px'
        $('footer .inner').css 'width', '1085px'
        $('footer .inner .col1').css 'width', '335px'
        $('footer .inner .col2').css 'width', '626px'
        $('footer .subcol-1').css 'width', '187px'
        $('footer .subcol-2').css 'width', '214px'
        $('footer .subcol-3').css 'width', '80px'

        setTimeout afterTimeout, 800

    main: () ->
        if !app.layout.getView()
            splash = new Thorax.Views['splashscreenview']()
            splash.render()

        model =
            model: new app.HomepageModel()

        app.layout.setView new Thorax.Views['index'](model), {} =
            transition: this.homeTransition

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


    pubblicazioni: () ->
        model =
            model: new app.PubblicazioniModel()

        app.layout.setView new Thorax.Views['pubblicazioni'](model), {} =
            transition: this.transition

    contatto: () ->
        app.layout.setView new Thorax.Views['contatto'](), {} =
            transition: this.transition

    contattoLink: (contatto) ->
        app.layout.setView new Thorax.Views['contatto'](), {} =
            transition: this.transition



    opere: () ->
        model =
            model: new app.OpereModel()

        app.layout.setView new Thorax.Views['opere'](model), {} =
            transition: this.transition


    ricerca: (query) ->
        model =
            model: new app.RicercaModel({} =
                id: query
            )
            query: query

        app.layout.setView new Thorax.Views['ricerca'](model), {} =
            transition: this.transition
)
