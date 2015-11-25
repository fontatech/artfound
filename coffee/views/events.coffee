Thorax.View.extend(
    name: 'events'
    tagName: 'div'
    className: 'view-class'
    template: Handlebars.compile($('#events').html())
    timeline: null

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()

        this._addChild this.timeline

        this.listenTo that, 'rendered', () ->
            that.timeline.render()
            that.$el.find('.timeline-container').html that.timeline.el
)
