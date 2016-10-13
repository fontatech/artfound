Thorax.View.extend(

    name: 'about'
    tagName: 'div'
    className: 'view-class about'
    template: Handlebars.compile($('#about').html())
    controllable: true

    events:
        'click .square': 'changeElement'
        'click .goleft': 'goleft'
        'click .goright': 'goright'
        'click .tooltip': 'stopMass'

    initialize: () ->
        this.trad = Translator.getTranslations()


    stopMass: (evt) ->
        evt.stopPropagation()
        evt.preventDefault()

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
            next.insertAfter(curr)
            next.get(0).offsetTop
            next.get(0).className = 'element on'
            curr.get(0).className = 'element on off'
            that.$el.find('.square').removeClass 'active'
            $(evt.target).addClass 'active'

            setTimeout(setOther, 2000)

    goleft: (evt) ->
        if !this.controllable
            return false

        that = this
        curr = that.$el.find('.element.on')

        setOther = () ->
            curr.get(0).className = 'element'
            #curr.appendTo(curr.parent())
            that.controllable = true

        count = that.$el.find('.element').length
        relToFind = curr.attr('data-rel') - 1
        relToFind = count if relToFind == 0

        next  = that.$el.find('.element[data-rel=' + relToFind + ']')

        if next.attr('data-rel') != curr.attr('data-rel')
            this.controllable = false
            next.insertAfter(curr)
            next.get(0).offsetTop
            next.get(0).className = 'element on'
            curr.get(0).className = 'element on off'
            that.$el.find('.square').removeClass 'active'
            $('.square[data-rel="' + next.attr('data-rel') + '"]').addClass 'active'

            setTimeout(setOther, 2000)

    goright: (evt) ->
        if !this.controllable
            return false

        that = this
        curr = that.$el.find('.element.on')

        setOther = () ->
            curr.get(0).className = 'element'
            that.controllable = true

        count = that.$el.find('.element').length
        next  = curr.next()

        next  = that.$el.find('.element').first() unless next.is('.element')

        if next.attr('data-rel') != curr.attr('data-rel')
            this.controllable = false
            next.insertAfter(curr)
            next.get(0).offsetTop
            next.get(0).className = 'element on'
            curr.get(0).className = 'element on off'
            that.$el.find('.square').removeClass 'active'
            $('.square[data-rel="' + next.attr('data-rel') + '"]').addClass 'active'

            setTimeout(setOther, 2000)
)
