window.app = window.app || {}

window.app.UserModel = Thorax.Model.extend(
    url: '/api/user'

    initialize: () ->
        that = this
)

window.app.UserInstance = new app.UserModel
