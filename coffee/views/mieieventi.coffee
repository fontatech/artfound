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

        this.listenTo this, 'rendered', (evt) ->
            afterTimeout = () ->
                that.$el.find('.popup-inner').addClass 'open'

            setTimeout afterTimeout, 50

    closePopup: (evt) ->
        that = this
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
