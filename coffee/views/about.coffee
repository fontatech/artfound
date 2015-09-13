Thorax.View.extend(

    name: 'about'
    tagName: 'div'
    className: 'view-class about'
    template: Handlebars.compile($('#about').html())
    controllable: true

    events:
        'click .square': 'changeElement'

    initialize: () ->
        this.trad = Translator.getTranslations()
        console.log 'about'


    changeElement: (evt) ->
        if !this.controllable
            return false

        that = this
        curr = that.$el.find('.element.on')

        setOther = () ->
            curr.get(0).className = 'element'
            curr.appendTo(curr.parent())
            that.controllable = true

        next = that.$el.find('.element[data-rel="' + $(evt.target).attr('data-rel') + '"]')

        if next.attr('data-rel') != curr.attr('data-rel')
            this.controllable = false
            next.get(0).className = 'element on'
            curr.get(0).className = 'element on off'
            that.$el.find('.square').removeClass 'active'
            $(evt.target).addClass 'active'

            setTimeout(setOther, 2000)
)
