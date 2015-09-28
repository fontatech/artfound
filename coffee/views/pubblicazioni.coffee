Thorax.View.extend(
    name: 'pubblicazioni'
    trad: null
    template: Handlebars.compile($('#pubblicazioni').html())
    tagName: 'div'
    className: 'view-class pubblicazioni'

    events:
        'click .download': 'downloadDocumentazione'
        'click .tipologia': 'changeTipologia'
            
    initialize: () ->
        this.trad = Translator.getTranslations()


    downloadDocumentazione: (evt) ->

        console.log 'asd'
        if !window.app.UserInstance.get('isLogged')
            evt.preventDefault()
            app.layout.popup = new Thorax.Views['loginpopup']()
            app.layout.popup.render()
            app.layout.popup.$el.appendTo document.body

    changeTipologia: (evt) ->
        value = $(evt.target).attr 'data-val'

        this.$el.find('.tipologia').removeClass 'active'
        $(evt.target).addClass 'active'

        switch value
            when 'ALL' then this.$el.find('.raccolta, .pubblicazione').addClass 'visible'
            when 'pubblicazione'
                this.$el.find('.raccolta').removeClass 'visible'
                this.$el.find('.pubblicazione').addClass 'visible'
            when 'raccolta'
                this.$el.find('.pubblicazione').removeClass 'visible'
                this.$el.find('.raccolta').addClass 'visible'
)
