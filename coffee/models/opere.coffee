window.app = window.app || {}

app.OpereModel = Thorax.Model.extend(
    url: () ->
        return '/api/opere-proprietarie/' + Translator.currentLang
)


