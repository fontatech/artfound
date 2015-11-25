window.app = window.app || {}

app.EventoModel = Thorax.Model.extend(
    urlRoot: () ->
        return '/api/evento/' + Translator.currentLang
)

