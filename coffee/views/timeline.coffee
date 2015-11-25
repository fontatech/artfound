Thorax.View.extend(
    
    name: 'timeline'
    tagName: 'div'
    className: 'timeline'
    template: Handlebars.compile($('#timeline-layout').html())
    trad: null

    events:
        'click .control': 'moveTimeline'
        'click .goright': 'moveRight'
        'click .goleft': 'moveLeft'

    initialize: () ->
        this.trad = Translator.getTranslations()
        this.setModel new app.EventsModel()

        this.listenTo this, 'rendered', () ->
            that = this
            afterTimeout = () ->
                width = that.$el.find('.control.active').get(0).offsetWidth
                left = that.$el.find('.control.active').get(0).offsetLeft
                that.$el.find('.control-line').css 'width', width + 'px'
                that.$el.find('.control-line').css 'left', left + 'px'

            count = this.$el.find('.timeline-event').length
            transform = ((100/count) * (3 - count))
            this.$el.find('.timeline-innerinner').css 'width', (count * 33.333333) + '%'
            this.transformEvents transform
            this.$el.find('.timeline-event').css 'width', (100/count) + '%'
            setTimeout afterTimeout, 100

    transformEvents: (transform) ->
        this.$el.find('.timeline-innerinner').css 'webkitTransform', 'translate3d(' + transform + '%,0,0)'
        this.$el.find('.timeline-innerinner').css 'mozTransform', 'translate3d(' + transform + '%,0,0)'
        this.$el.find('.timeline-innerinner').css 'msTransform', 'translate3d(' + transform + '%,0,0)'
        this.$el.find('.timeline-innerinner').css 'transform', 'translate3d(' + transform + '%,0,0)'
        this.$el.find('.timeline-innerinner').attr 'data-transform', transform

    moveTimeline: (evt) ->
        that = this
        evt.preventDefault()
        this.$el.find('.control').removeClass 'active'
        $(evt.target).addClass('active')
        width = that.$el.find('.control.active').get(0).offsetWidth
        left = that.$el.find('.control.active').get(0).offsetLeft
        that.$el.find('.control-line').css 'width', width + 'px'
        that.$el.find('.control-line').css 'left', left + 'px'
        value = that.$el.find('.control.active').attr 'data-value'
        count = this.$el.find('.timeline-event').length
        
        if value == 'new'
            transform = ((100/count) * (3 - count))
            this.$el.find('.timeline-innerinner').css 'width', (count * 33.333333) + '%'
            this.transformEvents transform
            this.$el.find('.timeline-event').css 'width', (100/count) + '%'
        else
            if parseInt(value) == (new Date()).getFullYear()
                transform = ((100/count) * (4 - count))
                this.$el.find('.timeline-innerinner').css 'width', (count * 33.333333) + '%'
                this.transformEvents transform
                this.$el.find('.timeline-event').css 'width', (100/count) + '%'
            else
                last = parseInt this.$el.find('.timeline-event[data-year="' + value + '"]').last().attr('data-order')
                if last <= 3
                    transform = 0
                else
                    transform = ((100/count) * (3 - last))

                this.$el.find('.timeline-innerinner').css 'width', (count * 33.333333) + '%'
                this.transformEvents transform
                this.$el.find('.timeline-event').css 'width', (100/count) + '%'

    moveRight: (evt) ->
        count = this.$el.find('.timeline-event').length
        transform = this.$el.find('.timeline-innerinner').attr 'data-transform'


        if parseFloat(transform) > ((100/count) * (3 - count))
            transform = parseFloat(transform) - (100/count)

        this.transformEvents transform

    moveLeft: (evt) ->
        count = this.$el.find('.timeline-event').length
        transform = this.$el.find('.timeline-innerinner').attr 'data-transform'

        if parseFloat(transform) < 0
            transform = parseFloat(transform) + (100/count)

        this.transformEvents transform
)
