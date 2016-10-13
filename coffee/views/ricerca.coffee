Thorax.View.extend(
    name: 'ricerca'
    tagName: 'div'
    className: 'view-class ricerca'
    template: Handlebars.compile($('#ricerca').html())
    tooltip: undefined

    events:
        'mouseover [data-has-tooltip]': 'openTooltip'
        'mouseout [data-has-tooltip]': 'closeTooltip'
        'click [data-has-tooltip]': 'openText'
        'keyup #searchtext': 'doSearch'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()

    openTooltip: (evt) ->
        data = $(evt.target).attr 'data-has-tooltip'
        if this.tooltip
            this.tooltip.className = 'tooltip-d open'
        else
            this.tooltip = document.createElement 'div'
            this.tooltip.className = 'tooltip-d'
            this.tooltip.textContent = data
            evt.target.appendChild this.tooltip
            this.tooltip.offsetLeft
            this.tooltip.className = 'tooltip-d open'

    closeTooltip: (evt) ->
        this.tooltip.className = 'tooltip-d'


    openText: (evt) ->
        that = this
        this.$el.find('.has-tooltip').css 'display', 'none'
        $('#searchtext').css 'display', 'inline-block'
        $('#searchtext').focus()

    cerca: (evt) ->
        evt.preventDefault() if evt
        href = '/ricerca/' + encodeURI(this.$el.find('#searchtext').val())
        Backbone.history.navigate href, true

    doSearch: (evt) ->
        this.cerca() if evt.keyCode == 13
)


