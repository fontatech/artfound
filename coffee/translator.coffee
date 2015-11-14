window.Translator =
    languages: ['it', 'en'],

    currentLang: 'it',

    _translations: null,

    setLanguage: (lang) ->
        this.currentLang = lang;
        localStorage.setItem('currentLanguage', lang)

    setDefaultLanguage: () ->
        this.currentLang = navigator.language

    getTranslations: () ->
        return this._translations[this.currentLang]

    init: () ->
        this.currentLang = localStorage.getItem('currentLanguage') if localStorage.getItem('currentLanguage')

        $.ajax(
            dataType: 'json'
            url: '/api/translations'
            success: (translations) ->
                Translator._translations = translations
                Translator.trigger('loaded')
        )

_.extend(Translator, Backbone.Events);

