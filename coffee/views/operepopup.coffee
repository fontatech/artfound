Thorax.View.extend(
    name: 'operepopup'
    tagName: 'div'
    className: 'popup operepopup'
    template: Handlebars.compile($('#popup-opere').html())
    trad: null

    events:
        'click .popup-close': 'closePopup'
        'click': 'closePopup'
        'click .popup-inner': 'stopPropagation'
        'click .labelpref': 'checkLabel'
        'click .invio': 'sendContact'

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

    goError: (selector) ->
        afterTimeout = () ->
            el.removeClass 'has-shake'
        afterTimeout2 = () ->
            el.removeClass 'has-error'

        el = $(selector)
        el.addClass 'has-shake'
        el.addClass 'has-error'

        setTimeout afterTimeout, 600
        setTimeout afterTimeout2, 3000

    sendContact: (evt) ->
        evt.preventDefault()
        rectelephone = this.$el.find('input').val()
        dettagli = this.$el.find('textarea').val()
        maggioriinfo = this.$el.find('[data-id="maggioriinfo"]').hasClass 'checked'
        acquisto = this.$el.find('[data-id="acquisto"]').hasClass 'checked'
        prestito = this.$el.find('[data-id="prestito"]').hasClass 'checked'
        that = this

        if !maggioriinfo and !acquisto and !prestito
            this.goError '.labelpref'
            return false

        if !rectelephone
            this.goError 'input'
            return false

        data =
            rectelephone: rectelephone
            dettagli: dettagli
            maggioriinfo: maggioriinfo
            acquisto: acquisto
            prestito: prestito

        $.post('/api/infoopera', data, (resp) ->
            resp = JSON.parse resp
            newel = that.$el.find('.toshow')
            afterTimeout = () ->
                that.$el.find('.tohide').css 'display', 'none'
                newel.css 'display', 'block'
                newel.get(0).offsetTop
                newel.addClass 'go'
                
            if resp.status == 'OK'
                that.$el.find('.tohide').css 'opacity', '0'

                setTimeout afterTimeout, 300
        )
)
