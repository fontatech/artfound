window.app = window.app || {}

window.app.UserModel = Thorax.Model.extend(
    url: '/api/user'

    initialize: () ->
        that = this
        this.listenTo this, 'sync', () ->
            console.log that.toJSON()
)

window.app.UserInstance = new app.UserModel
