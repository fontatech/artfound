Thorax.View.extend(
    name: 'preferenzepopup'
    tagName: 'div'
    className: 'popup preferenze'
    template: Handlebars.compile($('#popup-preferenze').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click .labelpref': 'checkLabel'

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

    checkLabel: (evt) ->
        evt.preventDefault()
        $(evt.target).toggleClass 'checked'

)

