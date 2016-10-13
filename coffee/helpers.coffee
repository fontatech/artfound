$(() ->

    Handlebars.registerHelper('eventClass', (type) ->
        return 'current' if type == 'PRESENT'
        return 'future' if type == 'FUTURE'
    )

    Handlebars.registerHelper('eventType', (type, currentText, futureText) ->
        switch type
            when 'FUTURE' then return new Handlebars.SafeString '<div class="tl-eventtype">' + futureText + '</div>'
            when 'PRESENT' then return new Handlebars.SafeString '<div class="tl-eventtype">' + currentText + '</div>'
            when 'PAST' then return ''
    )

    Handlebars.registerHelper('eventTypeAll', (type, currentText, futureText, pastText) ->
        switch type
            when 'FUTURE' then return new Handlebars.SafeString '<div class="tl-eventtype">' + futureText + '</div>'
            when 'PRESENT' then return new Handlebars.SafeString '<div class="tl-eventtype">' + currentText + '</div>'
            when 'PAST' then return new Handlebars.SafeString '<div class="tl-eventtype">' + pastText + '</div>'
    )

    Handlebars.registerHelper('getClass', (id) ->
        return 'current' if id == 1
        return 'next' if id == 2
        return 'over' if id == 3

        return ''
    )

    Handlebars.registerHelper('loggedLayout', (isLogged, mieiEventi, logout, accedi) ->
        return new Handlebars.SafeString('<div class="accedi">' + accedi + '</div>') if !isLogged
        return new Handlebars.SafeString '<div class="rightmenu"><div class="miei-eventi">' + mieiEventi + '</div> <span class="nomobile">-</span> <div class="logout">' + logout + '</div></div>'
    )

    Handlebars.registerHelper('encname', (name) ->
        return name.replace /\ /g, '-'
    )

    Handlebars.registerHelper('decname', (name) ->
        return name.replace /-/g, ' '
    )
)
