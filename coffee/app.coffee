$( (evt) ->

    app._goToNonHome = () ->
        element = document.getElementById('main-container')
        afterTransition = () ->
            $('header .col-dx').show()
            $('header .col-center').css('width', '')
            element.style.margin = ''


        element.style.width = '1000px'
        oldmargin = element.style.marginLeft
        element.style.margin = '60px auto'
        newmargin = ((window.innerWidth - 1000) / 2) + 'px'
        element.style.marginLeft = oldmargin

        element.offsetWidth

        element.style.marginLeft = newmargin

        $('#homelateral').removeClass 'open'
        app.isHome = false

        setTimeout afterTransition, 500

    app._goToHomeLayout = () ->
        element = document.getElementById('main-container')
        margin  =  getComputedStyle(element).marginLeft
        element.style.marginLeft = margin
        element.style.marginRight = '0px'
        element.style.width = '754px'
        $('header .col-center').css('width', '580px')
        $('header .col-dx').hide()

        element.offsetWidth
        element.style.marginLeft = '594px'
        $('#homelateral').addClass 'open'

        app.isHome = true


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
