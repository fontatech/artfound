Thorax.View.extend(
    
    name: 'bestslider'
    tagName: 'div'
    className: 'bestslider'
    template: Handlebars.compile($('#bestslider-layout').html())
    trad: null
    running: false

    events:
        'click .goright': 'goright'
        'click .goleft': 'goleft'

    goright: (evt) ->
        return false if this.running

        this.running = true
        that = this
        current = this.$el.find('.slide.current')
        next = this.$el.find('.slide.next')
        over = this.$el.find('.slide.over')

        afterTimeout = () ->
            current.removeClass 'out'
            current.appendTo current.parent()
            over.removeClass 'over'
            next.removeClass 'next'
            $(that.$el.find('.slide').get(2)).addClass 'over'
            that.running = false

        current.removeClass 'current'
        current.addClass 'out'
        next.addClass 'current'
        over.addClass 'next'

        this.setTextures next.attr('data-id')

        setTimeout afterTimeout, 1000

    goleft: (evt) ->
        return false if this.running

        this.running = true
        that = this
        current = this.$el.find('.slide.current')
        next = this.$el.find('.slide.next')
        over = this.$el.find('.slide.over')
        newage = this.$el.find('.slide').last()

        afterTimeout2 = () ->
            next.removeClass 'next'
            next.addClass 'over'
            newage.css 'z-index', ''
            current.css 'z-index', ''
            newage.removeClass 'out'
            that.running = false

        afterTimeout1 = () ->
            that.setTextures newage.attr('data-id')
            current.addClass 'next'
            current.removeClass 'current'
            newage.addClass 'current'
            setTimeout afterTimeout2, 1000

        this.$el.find('.slide').removeClass 'over'
        newage.css 'z-index', '4'
        current.css 'z-index', '5'
        newage.addClass 'out'
        newage.prependTo newage.parent()

        setTimeout afterTimeout1, 50

    setTextures: (id) ->
        values = this.opere

        id = parseInt id

        for id2 in values
            if id2.id == id
                prnt = this.$el.find('.bestslider .legend')
                prnt.find('h2').html id2.titolo
                prnt.find('a').html id2.artista
                prnt.find('a').attr 'href', id2.artpermalink
                prnt.find('p').html id2.descrizione
                prnt.find('.measure').html id2.misure

                if id2.isDisponible
                    this.$el.find('.bestslider .disponibility-inner').text id2.isDisponible

)
