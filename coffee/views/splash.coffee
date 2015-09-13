Thorax.View.extend(

    tagName: 'div'
    id: 'splashscreen'
    slider: null
    template: Handlebars.compile($('#splash').html())
    name: 'splashscreenview'

    events:
        'click .acceptcookie': 'acceptCookie',
        'mousemove .slider': 'changeCursor',
        'mouseout .slider': 'hideCursor',
        'click .slider': 'hideSplash'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.listenTo(this, 'rendered', () ->
            openCookies = () ->
                that.$el.find('.cookies').addClass('open')

            $(document.body).addClass('noscroll')
            $(document.body).append(this.el)
            this.initSlider()

            setTimeout(openCookies, 200) if !CookieManager.getInstance().isAccepted()
        )

    acceptCookie: () ->
        CookieManager.getInstance().accept()
        this.$el.find('.cookies').removeClass('open')

    initSlider: () ->
        that = this
        sliderStep = () ->
            curr = that.$el.find('.element.on')
            setOther = () ->
                curr.get(0).className = 'element'

            if curr.next().is('div')
                next = curr.next()
            else
                next = that.$el.find('.element:first-child')

            next.get(0).className = 'element on'
            curr.get(0).className = 'element on off'

            setTimeout(setOther, 2000)

        this.slider = setInterval(sliderStep, 5000)

    changeCursor: (evt) ->
        cursor = this.$el.find('.cursor-pointer')
        cursor.css('opacity', 1)

        TweenLite.to(cursor, 0.4, {
            x: evt.clientX + 10,
            y: evt.clientY + 10,
            force3D: true
        })

    hideCursor: (evt) ->
        this.$el.find('.cursor-pointer').css('opacity', 0)

    hideSplash: (evt) ->
        that = this

        this.$el.addClass('hidden')
        $(document.body).removeClass('noscroll')

        setTimeout((->
            that.$el.css('display', 'none')
        ), 800)
)
