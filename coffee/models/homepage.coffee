window.app = window.app || {}

app.HomepageModel = Thorax.Model.extend(
    url: () ->
        return '/api/homepage/' + Translator.currentLang
)

