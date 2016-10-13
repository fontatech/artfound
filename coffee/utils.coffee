
app.getHomeImages = () ->
    return ['01-home.jpg', '02-home.jpg', '03-home.jpg']

app.getViewportWidth = () ->
    return Math.min(document.documentElement.clientWidth, window.innerWidth || screen.width)

app.loadImg = (img) ->
    imgt = new Image()
    imgt.src = '/img/home/' + img
    imgt.onload = () ->
        console.log 'ok'
        return true

app.getRandomInt = (min, max) ->
      return Math.floor(Math.random() * (max - min)) + min

app.getRandImage = () ->
    rand = app.getRandomInt(0,3)
    return app.getHomeImages()[rand]

app.loadHomeImages = () ->
    imgs = app.getHomeImages()
    app.loadImg img for img in imgs

app.getHomeWidth = () ->
    totWidth = app.getViewportWidth()

    if totWidth >= 1800
        return '826px'
    else if totWidth >= 1480
        return '754px'
    else if totWidth >= 1130
        return '590px'
    else
        return ''

app.getContainerWidth = () ->
    totWidth = app.getViewportWidth()

    if totWidth >= 1800
        return 1215
    else if totWidth >= 1480
        return 1000
    else if totWidth >= 1130
        return 825
    else
        return ''

app.getMarginLeft = () ->
    totWidth = app.getViewportWidth()

    if totWidth >= 1800
        return '721px'
    else if totWidth >= 1480
        return '594px'
    else if totWidth >= 1130
        return '443px'
    else
        return ''

app.getColCenter = () ->
    totWidth = app.getViewportWidth()

    if totWidth >= 1800
        return '636px'
    else if totWidth >= 1480
        return '580px'
    else if totWidth >= 1130
        return '433px'
    else
        return ''


app._goToNonHome = () ->
    totWidth = app.getViewportWidth()

    element = document.getElementById('main-container')
    afterTransition = () ->
        $('header .col-dx').show()
        $('header .col-center').css('width', '')
        $('.main-menu').removeClass 'piccino'
        element.style.transition = 'none'
        element.style.margin = ''
        element.offsetLeft
        element.style.transition = ''

    element.style.width = ''
    oldmargin = element.style.marginLeft
    if app.getViewportWidth() >= 1130
        element.style.margin = '60px auto'
        newmargin = ((window.innerWidth - app.getContainerWidth()) / 2) + 'px'
        element.style.marginLeft = oldmargin

        element.offsetWidth

        element.style.marginLeft = newmargin
    else
        element.style.margin = ''


    $('#homelateral').removeClass 'open'
    app.isHome = false

    #Footer restyle (change for responsive)
    $('footer .inner').css 'margin-left', ''
    $('footer .inner').css 'width', ''
    $('footer .inner .col1').css 'width', ''
    $('footer .inner .col2').css 'width', ''
    $('footer .subcol-1').css 'width', ''
    $('footer .subcol-2').css 'width', ''
    $('footer .subcol-3').css 'width', ''

    setTimeout afterTransition, 500

app._goToHomeLayout = () ->
    totWidth = app.getViewportWidth()

    element = document.getElementById('main-container')
    margin  =  getComputedStyle(element).marginLeft

    if app.getViewportWidth() >= 1130
        element.style.marginLeft = margin
        element.style.marginRight = '0px'
    else
        element.style.marginLeft = ''
        element.style.marginRight = ''

    element.style.width = app.getHomeWidth()
    $('.main-menu').addClass 'piccino' if app.getViewportWidth() >= 1130
    $('header .col-center').css 'width', app.getColCenter()
    $('header .col-dx').hide() if app.getViewportWidth() >= 1130

    #Footer restyle (change for responsive)
    $('footer .inner').css 'margin-left', app.getFooterMarginLeft()
    $('footer .inner').css 'width', app.getFooterWidth()
    $('footer .inner .col1').css 'width', app.getFooterCol1()
    $('footer .inner .col2').css 'width', app.getFooterCol2()
    $('footer .subcol-1').css 'width', app.getFooterSubcol1()
    $('footer .subcol-2').css 'width', app.getFooterSubcol2()
    $('footer .subcol-3').css 'width', app.getFooterSubcol3()

    element.offsetWidth
    element.style.marginLeft = app.getMarginLeft()
    $('#homelateral').addClass 'open'

    app.isHome = true


app.getFooterMarginLeft = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '340px'
    else if totWidth > 1480
        return '261px'
    else if totWidth > 1130
        return '196px'
    else
        return ''

app.getFooterWidth = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '1207'
    else if totWidth > 1480
        return '1085px'
    else if totWidth > 1130
        return '837px'
    else
        return ''

app.getFooterCol1 = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '381px'
    else if totWidth > 1480
        return '335px'
    else if totWidth > 1130
        return '248px'
    else
        return ''

app.getFooterCol2 = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '665px'
    else if totWidth > 1480
        return '626px'
    else if totWidth > 1130
        return '502px'
    else
        return ''

app.getFooterSubcol1 = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '221px'
    else if totWidth > 1480
        return '187px'
    else if totWidth > 1130
        return '151px'
    else
        return ''

app.getFooterSubcol2 = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '253px'
    else if totWidth > 1480
        return '214px'
    else if totWidth > 1130
        return '177px'
    else
        return ''

app.getFooterSubcol3 = () ->
    totWidth = app.getViewportWidth()

    if totWidth > 1800
        return '140px'
    else if totWidth > 1480
        return '80px'
    else if totWidth > 1130
        return '107px'
    else
        return ''
