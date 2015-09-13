$.mockjax(
    url: '/api/translations',
    responseText: {"it":{"aboutpaneldescr":"<p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectutur. Curabit blandit tempus porttitor. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cras justo odio, dapibus ac facilisis in, egestas eget quam.</p>","aboutpaneltitle":"TITOLO CAPITOLO","sedeartfound":"Sede di Art Found Trust gallery","aboutDescr":"Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum messa justo sit amet risus.","eventiRecenti":"Eventi pi&ugrave; recenti","titoloevento":"Titolo dell'evento","eventFiuciur":"EVENTO FUTURO","eventCurrent":"EVENTO IN CORSO","events":"EVENTI","home":"HOME","about":"ABOUT","eventi":"EVENTI","artisti":"ARTISTI","pubblicazioni":"PUBBLICAZIONI","contatto":"CONTATTO","cookiepolicy":"Questo sito web utilizza i cookie per assicurarti la migliore esperienza di navigazione possibile. Navigandolo ne accetti l'utilizzo. Per maggiori informazioni puoi consultare la nostra <a href=\"/privacy\">Privacy Policy</a> - <span class=\"acceptcookie\">[Accetta]</span>","clicktoenter":"Clicca per entrare"},"en":{"home":"HOME","about":"ABOUT","eventi":"EVENTS","artisti":"ARTISTS","pubblicazioni":"PUBBLICATIONS","contatto":"CONTACT US","cookiepolicy":"Questo sito web utilizza cookie per assicurarti la migliore esperienza di navigazione possibile. Navigandolo ne accetti l'utilizzo. Per maggiori informazioni puoi consultare la nostra <a href=\"/privacy\">Privacy Policy</a> - <span class=\"acceptcookie\">[Accetta]</span>"}}
)

$.mockjax(
    url: '/api/events',
    responseText: {} =
        current: {} =
            title: 'PER SOTTRAZIONE Intorno a maurice Blanchot e la scrittura del disastro, tra frammentazione e ricostruzione',
            img: '/img/prova1.jpg'
            date: '1-31 Luglio 2015'
            permalink: 'per-sottrazione'

        future: {} =
            title: 'PER SOTTRAZIONE Intorno a maurice Blanchot e la scrittura del disastro, tra frammentazione e ricostruzione',
            img: '/img/prova1.jpg'
            date: '1-31 Luglio 2015'
            permalink: 'per-sottrazione'

        eventi: [
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'PAST',
                img: '/img/prova1.jpg'
                order: 1,
                date: '1-31 Luglio 2014'
                year: 2014
                permalink: 'per-sottrazione'
            },
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'PAST',
                img: '/img/prova1.jpg'
                order: 2,
                date: '1-31 Luglio 2014'
                year: 2014
                permalink: 'per-sottrazione'
            },
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'PAST',
                img: '/img/prova1.jpg'
                order: 3,
                date: '1-31 Luglio 2014'
                year: 2014
                permalink: 'per-sottrazione'
            },
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'PAST',
                img: '/img/prova1.jpg'
                order: 4,
                date: '1-31 Luglio 2015'
                year: 2015
                permalink: 'per-sottrazione'
            },
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'PRESENT',
                img: '/img/prova1.jpg'
                order: 5,
                date: '1-31 Luglio 2015'
                year: 2015
                permalink: 'per-sottrazione'
            },
            {
                title: 'Cras justo odio, dapibus as facilisis in, efestat eget quam',
                type: 'FUTURE',
                img: '/img/prova1.jpg',
                order: 6,
                date: '1-31 Luglio 2015'
                year: 2015
                permalink: 'per-sottrazione'
            }
        ]

)
