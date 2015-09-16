Thorax.View.extend(
    name: 'evento'
    tagName: 'div'
    className: 'view-class evento'
    template: Handlebars.compile($('#evento').html())
    timeline: null

    events:
        'click .click-documentazione': 'downloadDocumentazione'
        'click .click-relatore': 'relatorePopup'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()

        this._addChild this.timeline

        this.setModel new app.EventoModel({} =
            id: this.eventoId
        )

        this.listenTo that, 'rendered', () ->
            that.bestslider = new Thorax.Views['bestslider']({} =
                opere: that.model.get('opere')
            )
            that._addChild that.bestslider

            that.timeline.render()
            that.bestslider.render()
            that.$el.find('.timeline-container').html that.timeline.el
            that.$el.find('.bestslider-container').html that.bestslider.el

    downloadDocumentazione: (evt) ->

        if !window.app.UserInstance.get('isLogged')
            evt.preventDefault()
            app.layout.popup = new Thorax.Views['loginpopup']()
            app.layout.popup.render()
            app.layout.popup.$el.appendTo document.body


    relatorePopup: (evt) ->
        id = parseInt($(evt.target).attr('data-id'))
        relatori = this.model.get 'relatori'

        for rel in relatori
            if rel.id == id
                app.layout.popup = new Thorax.Views['relatorepopup'](
                    titolo: rel.name
                    descrizione: rel.description
                )

                app.layout.popup.render()
                app.layout.popup.$el.appendTo document.body
)

