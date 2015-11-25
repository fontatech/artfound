window.app = window.app || {}

app.EventsModel = Thorax.Model.extend(
    url: () ->
        return '/api/events/' + Translator.currentLang
)
