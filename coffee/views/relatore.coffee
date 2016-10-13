Thorax.View.extend(
    name: 'relatorepopup'
    tagName: 'div'
    className: 'popup relatore'
    template: Handlebars.compile($('#popup-relatore').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'

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
        afterTimeout = () ->
            that.undelegateEvents()
            that.$el.removeData().unbind()
            that.remove()

        this.$el.find('.popup-inner').css 'opacity', '0'

        setTimeout afterTimeout, 300

    stopPropagation: (evt) ->
        evt.stopPropagation()
)

