Thorax.View.extend(
    name: 'contatto'
    tagName: 'div'
    className: 'view-class contatto'
    template: Handlebars.compile($('#contatto').html())
    timeline: null
    map: null

    initialize: () ->
        that = this
        this.trad = Translator.getTranslations()
        this.timeline = new Thorax.Views['timeline']()

        this._addChild this.timeline

        this.listenTo that, 'rendered', () ->
            afterTimeout = () ->
                that.createMap()

            that.timeline.render()
            that.$el.find('.timeline-container').html that.timeline.el
            setTimeout afterTimeout, 100


    createMap: () ->
        console.log document.getElementById('map')

        this.map = new google.maps.Map document.getElementById('map'), {} =
            center:
                lat: 45.472324
                lng: 9.203462
            scrollwheel: false
            zoom: 17
            disableDefaultUI: true

        marker = new MarkerWithLabel
            position:
                lat: 45.472324
                lng: 9.203462
            map: this.map
            labelContent: "Corso Venezia, 44"
            labelAnchor: new google.maps.Point(22, 0)
            labelClass: "labels"

)

