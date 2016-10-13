Thorax.View.extend(
    name: 'ricercapopup'
    tagName: 'div'
    className: 'popup ricercap'
    template: Handlebars.compile($('#popup-ricerca').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click .cliccacerca': 'showAndFocus'
        'click #avviaricerca': 'cerca'
        'keyup #ricercarapida': 'cercaIfEnter'

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

    showAndFocus: (evt) ->
        evt.preventDefault()

        this.$el.find('.cliccacerca').css 'display', 'none'
        $('#ricercarapida').css 'display', 'block'
        $('#ricercarapida').focus()

    cerca: (evt) ->
        evt.preventDefault() if evt

        href = '/ricerca/' + encodeURI(this.$el.find('#ricercarapida').val())

        this.closePopup()
        Backbone.history.navigate href, true

    cercaIfEnter: (evt) ->
        this.cerca() if evt.keyCode == 13
)
