window.app = window.app || {}

app.PubblicazioniModel = Thorax.Model.extend(
    url: () ->
        return '/api/pubblicazioni/' + Translator.currentLang
)


