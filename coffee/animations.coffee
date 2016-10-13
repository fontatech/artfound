app.initParallax = () ->
    $(window).on 'scroll', () ->
        viewport = $(window).height()
        scroll   = window.scrollY
        footer   = $('footer').height()
        tot      = $(document).height()

        TweenLite.to $('.parallaxer:not(.plus), .parallaxer-mobi'), 0, {} =
            bottom: -(scroll/7)

        TweenLite.to $('.parallaxer.plus'), 0, {} =
            bottom: -(scroll/4)

        bottomPoint = scroll + viewport
        toStart     = tot - footer
        parallaxes  = -((bottomPoint - toStart)/2)

        parallaxes  = -146 if parallaxes < -146

        if bottomPoint >= toStart
            TweenLite.to $('.footer-parallaxer'), 0, {} =
                bottom: parallaxes

    $(window).on 'resize', () ->
        app._goToHomeLayout() if $('#homelateral').hasClass 'open'
