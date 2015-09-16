Thorax.View.extend(
    name: 'artista'
    tagName: 'div'
    className: 'view-class artista'
    template: Handlebars.compile($('#artista').html())
    timeline: null
    currentLetter: 'ALL'
    bestslider: null

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()

        this._addChild this.timeline

        this.listenTo that, 'rendered', () ->
            that.bestslider = new Thorax.Views['bestslider']({} =
                opere: that.model.get('opere')
            )
            that._addChild that.bestslider

            that.timeline.render()
            that.bestslider.render()
            that.$el.find('.timeline-container').html that.timeline.el
            that.$el.find('.bestslider-container').html that.bestslider.el


)
