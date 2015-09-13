$(() ->

    Handlebars.registerHelper('eventClass', (type) ->
        return 'future' if type == 'FUTURE'
    )

    Handlebars.registerHelper('eventType', (type, currentText, futureText) ->
        switch type
            when 'FUTURE' then return new Handlebars.SafeString '<div class="tl-eventtype">' + futureText + '</div>'
            when 'PRESENT' then return new Handlebars.SafeString '<div class="tl-eventtype">' + currentText + '</div>'
            when 'PAST' then return ''

    )

)
