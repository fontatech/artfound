Thorax.View.extend(
    name: 'artisti'
    tagName: 'div'
    className: 'view-class artisti'
    template: Handlebars.compile($('#artisti').html())
    timeline: null
    currentLetter: 'ALL'

    events:
        'click .select': 'changeletter'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()

        this._addChild this.timeline

        this.setModel new app.ArtistsModel()
        console.log(this.model)

        this.listenTo that, 'rendered', () ->
            that.timeline.render()
            that.$el.find('.timeline-container').html that.timeline.el

    changeletter: (evt) ->
        that = this
        letter = $(evt.target).attr('data-letter')

        if letter == this.currentLetter
            return false

        if (this.$el.find('.artista[data-letter="' + letter + '"]').length == 0) and (letter != 'ALL')
            return false

        this.currentLetter = letter

        afterTimeout = () ->
            that.$el.find('.artista').removeClass 'okmargin'
            that.$el.find('.artista').css 'display', 'none'

            if letter == 'ALL'
                that.$el.find('.artista').css 'display', 'block'
                that.$el.find('.artista').addClass 'okmargin'
                that.$el.find('.artista').addClass 'visible'
            else
                that.$el.find('.artista[data-letter="' + letter + '"]').css 'display', 'block'
                that.$el.find('.artista[data-letter="' + letter + '"]').addClass 'okmargin'
                that.$el.find('.artista[data-letter="' + letter + '"]').addClass 'visible'

        this.$el.find('.artista').removeClass 'visible'

        this.$el.find('.select').removeClass 'active'
        $(evt.target).addClass 'active'

        setTimeout afterTimeout, 450

)
