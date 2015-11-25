window.app = window.app || {}

app.ArtistaModel = Thorax.Model.extend(
    urlRoot: () ->
        return '/api/artista/' + Translator.currentLang
)


