Thorax.View.extend(
    name: 'mieieventipopup'
    tagName: 'div'
    className: 'popup mieieventi'
    template: Handlebars.compile($('#popup-mieieventi').html())
    trad: null
    eventi: []

    events:
        'click .popup-close': 'closePopup'
        'click .popup-chiudi': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click a': 'closeAndGo'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()

        vWidth = app.getViewportWidth()

        if vWidth < 900
            top = document.body.scrollTop || document.documentElement.scrollTop
        else
            top = 0

        this.listenTo this, 'rendered', (evt) ->
            afterTimeout = () ->
                that.$el.find('.popup-inner').addClass 'open'

            that.$el.css 'top', top
            that.el.offsetLeft

            setTimeout afterTimeout, 50

    closePopup: (evt) ->
        that = this

        if evt
            evt.stopPropagation()
            evt.preventDefault()

        afterTimeout = () ->
            that.undelegateEvents()
            that.$el.removeData().unbind()
            that.remove()

        this.$el.find('.popup-inner').css 'opacity', '0'

        setTimeout afterTimeout, 300

    stopPropagation: (evt) ->
        evt.stopPropagation()

    closeAndGo: (evt) ->
        evt.preventDefault()
        Backbone.history.navigate $(evt.target).attr('href'), true
        this.closePopup()
)
