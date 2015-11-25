window.CookieManager = (() ->
    instance = null

    init = () ->
        return {} =
            isAccepted: () ->
                localStorage and localStorage.getItem('cookie') == 'accepted'

            accept: () ->
                localStorage.setItem('cookie', 'accepted') if localStorage

            reset: () ->
                localStorage.removeItem('cookie') if localStorage

    return {} =
        getInstance: () ->
            instance = init() if !instance
            instance
)()
