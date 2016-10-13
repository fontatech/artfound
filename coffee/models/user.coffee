window.app = window.app || {}

window.app.UserModel = Thorax.Model.extend(
    urlRoot: () ->
        return '/api/user/' + Translator.currentLang

    initialize: () ->
        that = this
)

window.app.UserInstance = new app.UserModel
