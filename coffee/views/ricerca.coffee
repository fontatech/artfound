Thorax.View.extend(
    name: 'ricerca'
    tagName: 'div'
    className: 'view-class ricerca'
    template: Handlebars.compile($('#ricerca').html())
    tooltip: undefined

    events:
        'mouseover [data-has-tooltip]': 'openTooltip'
        'mouseout [data-has-tooltip]': 'closeTooltip'

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()

    openTooltip: (evt) ->
        data = $(evt.target).attr 'data-has-tooltip'
        if this.tooltip
            this.tooltip.className = 'tooltip open'
        else
            this.tooltip = document.createElement 'div'
            this.tooltip.className = 'tooltip'
            this.tooltip.textContent = data
            evt.target.appendChild this.tooltip
            this.tooltip.offsetLeft
            this.tooltip.className = 'tooltip open'

    closeTooltip: (evt) ->
        this.tooltip.className = 'tooltip'
)


