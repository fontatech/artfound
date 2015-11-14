window.app = window.app || {}

app.RicercaModel = Thorax.Model.extend(
    urlRoot: () ->
        return '/api/ricerca/' + Translator.currentLang
)


