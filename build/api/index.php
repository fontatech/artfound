<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', true);

// Include global functions
require_once 'functions.php';

// Include slim framework and init
require 'vendor/slim/Slim/Slim.php';
\Slim\Slim::registerAutoloader();

// Include php_activerecord and init
require_once 'vendor/php-activerecord/ActiveRecord.php';
ActiveRecord\Config::initialize(function ($cfg) {
    $cfg->set_model_directory('models');
    $cfg->set_connections(array(
        'development' => 'mysql://root:caligola@localhost/artfound'
        //'development' => 'mysql://admin:Abiepa2u@sql.artfoundtrust.com.cloud.seeweb.it/artfound'
    ));

    $cfg->set_default_connection('development');
});

$app = new \Slim\Slim();
$app->log->setEnabled(true);

////// Costanti per l'applicazione
const INFO_MAIL = 'mb@gbrweb.it';
const SENDER_MAIL = 'info@artfoundtrust.com';

/**********************************************
 * TRANSLATIONS
 **********************************************/
$app->get('/translations', function () {
    $langs  = Language::find('all');
    $labels = Label::all();

    $data = array();

    foreach ($langs as $l) {
        $data[$l->shortname] = array();

        foreach ($labels as $lab) {
            $labelValue = LabelTranslation::find_by_id_language_and_id_label($l->id_language, $lab->id_label);
            if ($labelValue) {
                $data[$l->shortname][$lab->text] = $labelValue->value;
            } else {
                $data[$l->shortname][$lab->text] = $lab->text;
            }
        }

    }

    echo json_encode($data);
});


/**********************************************
 * ARTISTS
 **********************************************/
$app->get('/artists', function () {
    $data = Artist::all();
    $resp = array(
        'artists' => array(),
        'letters' => array()
    );

    foreach ($data as $a) {
        $exploded = explode(' ', $a->name);
        $pts = explode(' ', $a->name);
        $first = substr($pts[1], 0, 1);

        if (!in_array($first, $resp['letters'])) {
            $resp['letters'][] = $first;
        }

        $resp['artists'][] = array(
            'name' => $a->name,
            'subname' => $a->name,
            'img' => '/upload/artisti/' . $a->image,
            'letter' => strtoupper($exploded[1][0]),
            'permalink' => $a->permalink
        );
    }

    sort($resp['letters']);

    echo json_encode($resp);
});

/**********************************************
 * ARTISTA
 **********************************************/
$app->get('/artista/:lang/:permalink', function ($lang, $permalink) {
    $data = Artist::find_by_permalink($permalink);
    $lang = Language::find_by_shortname($lang);
    $resp = array();

    if (!$data || !$lang)
        returnFalse();

    $title   = Translation::find_by_id_translation_and_id_language($data->id_description_title, $lang->id_language);
    $descr   = Translation::find_by_id_translation_and_id_language($data->id_description, $lang->id_language);
    $artists = Artist::all();

    $resp['name']  = $data->name;
    $resp['img']   = '/upload/artisti/' . $data->image;
    $resp['title'] = $title->content;
    $resp['description'] = $descr->content;

    for ($index = 0; $index < count($artists); $index++) {
        if ($artists[$index]->id_artist === $data->id_artist) {
            if ($index == 0) {
                $resp['prevLink'] = $artists[count($artists) - 1]->permalink;
            } else {
                $resp['prevLink'] = $artists[$index - 1]->permalink;
            }

            if ($index === count($artists)-1) {
                $resp['nextLink'] = $artists[0]->permalink;
            } else {
                $resp['nextLink'] = $artists[$index + 1]->permalink;
            }

            $resp['nextLink'] = '/artista/' . $resp['nextLink'];
            $resp['prevLink'] = '/artista/' . $resp['prevLink'];
        }
    }

    $resp['opere'] = array();
    $artworks = Opera::find('all', array(
        'conditions' => 'id_artist = ' . $data->id_artist
    ));

    $index = 1;

    foreach ($artworks as $aw) {
        $images = OperaImage::find('all', array(
            'conditions' => 'id_artwork = ' . $aw->id_artwork
        ));
        $titolo = Translation::find_by_id_translation_and_id_language($aw->id_title, $lang->id_language);
        $descr  = Translation::find_by_id_translation_and_id_language($aw->id_description, $lang->id_language);

        foreach ($images as $i) {
            $resp['opere'][] = array(
                'img'    => '/upload/opere/' . $i->image,
                'id'     => $index,
                'titolo' => $titolo->content,
                'descrizione' => $descr->content,
                'artista' => $data->name,
                'misure' => $aw->measurements,
                'artpermalink' => '/artista/' . $data->permalink
            );

            $index++;
        }
    }

    echo json_encode($resp);

});


/**********************************************
 * EVENTI
 **********************************************/
$app->get('/events/:lang', function ($lang) {
    $lang    = Language::find_by_shortname($lang);
    $events  = Event::find('all', array(
        'order' => 'start_date asc'
    ));

    $resp = array(
        'current' => array(),
        'future'  => array(),
        'eventi'  => array()
    );

    if (!$lang || !$events) {
        returnFalse();
    }

    $lang_id = $lang->id_language;

    $index = 1;

    foreach ($events as $evt) {
        $type = $evt->getType();

        if ($type === 'PRESENT') {
            $resp['current'] = array(
                'title' => $evt->getTitle($lang_id) . ' ' . $evt->getDescr($lang_id),
                'img'   => '/upload/eventi/' . $evt->main_image,
                'date'  => $evt->getLangDate($lang_id),
                'permalink' => $evt->permalink
            );
        }

        if ($type === 'FUTURE') {
            $resp['future'] = array(
                'title' => $evt->getTitle($lang_id) . ' ' . $evt->getDescr($lang_id),
                'img'   => '/upload/eventi/' . $evt->main_image,
                'date'  => $evt->getLangDate($lang_id),
                'permalink' => $evt->permalink
            );
        }

        $resp['eventi'][] = array(
            'type' => $type,
            'title' => $evt->getTitle($lang_id) . ' ' . $evt->getDescr($lang_id),
            'img'   => '/upload/eventi/' . $evt->main_image,
            'order' => $index,
            'date'  => $evt->getLangDate($lang_id),
            'permalink' => $evt->permalink,
            'year' => $evt->getYear()
        );

        $index++;
    }

    echo json_encode($resp);
});


/**********************************************
 * EVENTO
 **********************************************/
$app->get('/evento/:lang/:permalink', function ($lang, $permalink) {
    $lang = Language::find_by_shortname($lang);
    $evt  = Event::find_by_permalink($permalink);

    if (!$lang || !$evt) {
        returnFalse();
    }

    $lang_id = $lang->id_language;

    $prefs = array(
        'inaugurazione' => false,
        'conversazioni' => false,
        'notifiche'     => false,
        'preferiti'     => false
    );
    if (isset($_SESSION['logged'])) {
        $user = User::getLoggedUser();
        $inaugurazione = Preference::find_by_id_event_and_id_user_and_preference($evt->id_event, $user->id_user, 'inaugurazione');

        if ($inaugurazione && $inaugurazione->value == 1) {
            $prefs['inaugurazione'] = true;
        }

        $inaugurazione = Preference::find_by_id_event_and_id_user_and_preference($evt->id_event, $user->id_user, 'conversazioni');

        if ($inaugurazione && $inaugurazione->value == 1) {
            $prefs['conversazioni'] = true;
        }

        $inaugurazione = Preference::find_by_id_event_and_id_user_and_preference($evt->id_event, $user->id_user, 'preferiti');

        if ($inaugurazione && $inaugurazione->value == 1) {
            $prefs['preferiti'] = true;
        }

        $inaugurazione = Preference::find_by_id_event_and_id_user_and_preference($evt->id_event, $user->id_user, 'notifiche');

        if ($inaugurazione && $inaugurazione->value == 1) {
            $prefs['notifiche'] = true;
        }
    }

    $resp = array(
        'name' => $evt->getTitle($lang_id),
        'description' => $evt->getDescr($lang_id),
        'curatore' => $evt->curator_name,
        'img' => '/upload/eventi/' . $evt->main_image,
        'esposizione' => $evt->getEsposizione($lang_id),
        'inaugurazione' => $evt->getInaugurazione($lang_id),
        'conversazione' => $evt->getConversazione($lang_id),
        'type' => $evt->getType(),
        'isPast' => $evt->getType() == 'PAST',
        'isFuture' => $evt->getType() == 'FUTURE',
        'preferenze' => $prefs
    );

    $resp['artisti']        = $evt->getArtisti();
    $resp['opere']          = $evt->getOpere($lang_id);
    $resp['relatori']       = $evt->getSpeakers($lang_id);
    $resp['documentazione'] = $evt->getDocuments($lang_id);

    echo json_encode($resp);
});


/**********************************************
 * OPERE PROPRIETARIE
 **********************************************/
$app->get('/opere-proprietarie/:lang', function ($lang) {
    $lang = Language::find_by_shortname($lang);

    if(!$lang) {
        return false;
    }

    $lang_id = $lang->id_language;
    $opere = Opera::find('all', array(
        'conditions' => 'is_trust_artwork = 1'
    ));
    $index = 1;
    $resp = array(
        'artisti' => array(),
        'opere'   => array()
    );
    $artists = array();

    foreach ($opere as $o) {
        if (array_search($o->id_artist, $artists, true) === false) {
            $artists[] = $o->id_artist;
            $resp['artisti'][] = array(
                'name' => $o->getArtist()->name,
                'permalink' => '/artista/' . $o->getArtist()->permalink
            );
        }

        foreach ($o->getImages() as $i) {
            $resp['opere'][] = array(
                'img'          => '/upload/opere/' . $i->image,
                'id'           => $index,
                'titolo'       => $o->getTitle($lang_id),
                'artista'      => $o->getArtist()->name,
                'descrizione'  => $o->getDescription($lang_id),
                'misure'       => $o->measurements,
                'artpermalink' => '/artista/' . $o->getArtist()->permalink,
                'isDisponible' => $o->getIsDisponible($lang_id)
            );

            $index++;
        }
    }

    echo json_encode($resp);
});


/**********************************************
 * HOMEPAGE
 **********************************************/
$app->get('/homepage/:lang', function ($lang) {
    $lang    = Language::find_by_shortname($lang);
    $events  = Event::find('all', array(
        'order' => 'start_date asc'
    ));

    $resp = array(
        'incorso' => array(),
        'futuro'  => array()
    );

    if (!$lang || !$events) {
        returnFalse();
    }

    $lang_id = $lang->id_language;

    foreach ($events as $evt) {
        $type = $evt->getType();

        if ($type === 'PRESENT') {
            $resp['incorso'] = array(
                'title' => $evt->getTitle($lang_id),
                'description' => $evt->getDescr($lang_id),
                'img'   => '/upload/eventi/' . $evt->main_image,
                'permalink' => '/event/' . $evt->permalink
            );
        }

        if ($type === 'FUTURE') {
            $resp['futuro'] = array(
                'title' => $evt->getTitle($lang_id),
                'description' => $evt->getDescr($lang_id),
                'img'   => '/upload/eventi/' . $evt->main_image,
                'permalink' => '/event/' . $evt->permalink,
                'date' => $evt->getLangDate($lang_id)
            );
        }
    }

    echo json_encode($resp);
});


/**********************************************
 * PUBBLICAZIONI
 **********************************************/
$app->get('/pubblicazioni/:lang', function ($lang) {
    $lang = Language::find_by_shortname($lang);

    if (!$lang) {
        returnFalse();
    }

    $resp = array(
        'eventi' => array(),
        'raccolte' => array()
    );

    $lang_id = $lang->id_language;
    $events  = Event::find('all');
    $pubblications = Pubblication::find('all', array(
        'order' => 'creation_date desc'
    ));

    foreach ($events as $e) {
        $docs = $e->getDocuments($lang_id);

        if ($docs) {
            $resp['eventi'][] = array(
                'name' => $e->getTitle($lang_id) . ' ' . $e->getDescr($lang_id),
                'edits' => $docs
            );
        }
    }

    foreach ($pubblications as $p) {
        $resp['raccolte'][] = array(
            'title' => $p->getTitle($lang_id),
            'subtitle' => $p->getSubtitle($lang_id),
            'description' => $p->getDescription($lang_id),
            'price' => $p->formatPrice(),
            'date' => $p->getDate($lang_id),
            'img'  => '/upload/pubblicazioni/' . $p->image
        );
    }

    echo json_encode($resp);
});

/**********************************************
 * LOGIN
 **********************************************/
$app->post('/login', function () use ($app) {
    $email    = $app->request->post('email');
    $password = $app->request->post('password');

    $user = User::find_by_email_and_password($email, md5($password));

    if (!$user) {
        returnFalse();
    }

    $_SESSION['logged'] = $user->id_user;
    returnTrue();
});

/**********************************************
 * LOGOUT
 **********************************************/
$app->get('/logout', function () {
    if (isset($_SESSION['logged'])) {
        unset($_SESSION['logged']);
    }

    returnTrue();
});

/**********************************************
 * USER DATA
 **********************************************/
$app->get('/user/:lang', function ($lang) {
    if (isset($_SESSION['logged'])) {
        $user = User::getLoggedUser();

        if ($user) {
            $lang    = Language::find_by_shortname($lang);
            $lang_id = $lang->id_language;

            $resp = array();
            $eventi = Preference::find_all_by_id_user_and_preference($user->id_user, 'preferiti');

            foreach ($eventi as $e) {
                $evt = Event::find_by_id_event($e->id_event);

                if ($e->value == 1) {
                    $resp[] = array(
                        'permalink' => $evt->permalink,
                        'name' => strtoupper($evt->getTitle($lang_id)) . ' ' . $evt->getDescr($lang_id)
                    );
                }
            }

            $resp = array(
                'isLogged' => true,
                'name'     => $user->name,
                'email'    => $user->email,
                'eventi'   => $resp
            );
        } else {
            $resp = array(
                'isLogged' => false,
                'name'     => null,
                'email'    => null,
                'eventi'   => array()
            );
        }
    } else {
        $resp = array(
            'isLogged' => false,
            'name'     => null,
            'email'    => null,
            'eventi'   => array()
        );
    }

    echo json_encode($resp);
});

/**********************************************
 * REGISTER
 **********************************************/
$app->post('/register', function () use ($app) {
    $nome     = $app->request->post('nome');
    $email    = $app->request->post('email');
    $password = $app->request->post('password');

    if (!$nome || !$email || !$password) {
        returnFalse();
    }

    if (strlen($password) < 6) {
        returnFalse();
    }

    if (strlen($nome) < 3) {
        returnFalse();
    }

    try {
        $newUser = User::create(array(
            'name' => $nome,
            'email' => $email,
            'password' => md5($password)
        ));
    } catch (Exception $e) {
        $ret = array(
            'status' => 'KO',
            'field'  => 'email'
        );

        echo json_encode($ret);
        die();
    }

    $_SESSION['logged'] = $newUser->id_user;

    returnTrue();
});


/**********************************************
 * API DI RICERCA PER PAROLE CHIAVE
 **********************************************/
$app->get('/ricerca/:lang/:query', function ($lang, $query) {
    $lang    = Language::find_by_shortname($lang);
    $lang_id = $lang->id_language;

    // Prima cerco per gli eventi, controllo nel titolo e nella descrizione
    $events = Event::find('all', array(
        'order' => 'creation_date desc'
    ));

    $resp = array(
        'hasResults' => false,
        'events' => array(),
        'artists' => array(),
        'artworks' => array()
    );

    foreach ($events as $e) {
        if (strpos(strtolower($e->getTitle($lang_id)), strtolower($query)) !== false) {
            $resp['events'][] = array(
                'title'     => $e->getTitle($lang_id),
                'date'      => $e->getLangDate($lang_id),
                'image'     => '/upload/eventi/' . $e->main_image,
                'permalink' => $e->permalink
            );
        }
    }

    $artists = Artist::find('all');

    foreach ($artists as $a) {
        if (strpos(strtolower($a->name), strtolower($query)) !== false) {
            $resp['artists'][] = array(
                'name'      => $a->name,
                'image'     => $a->image,
                'permalink' => $a->permalink
            );
        }
    }

    $artworks = Opera::find('all');

    foreach ($artworks as $a) {
        if (strpos(strtolower($a->getTitle($lang_id)), strtolower($query))) {
            $imgs = OperaImage::find_all_by_id_artwork($a->id_artwork);
            $resp['artworks'][] = array(
                'title'     => $a->getTitle($lang_id),
                'image'     => '/upload/opere/' . $imgs[0]->image,
                'artist'    => $a->getArtist()->name,
                'permalink' => $a->getArtist()->permalink
            );
        }
    }

    if ($resp['events'] || $resp['artists'] || $resp['artworks']) {
        $resp['hasResults'] = true;
    }

    echo json_encode($resp);
});


/**********************************************
 * API DI INSERIMENTO PREFERENZE UTENTE
 **********************************************/
$app->post('/preferences/:evento', function ($evento) use ($app) {
    $_SESSION['logged'] = 1;
    if (!isset($_SESSION['logged'])) {
        returnFalse();
    }

    $req = $app->request;

    $user  = User::find_by_id_user($_SESSION['logged']);
    $event = Event::find_by_permalink($evento);

    if (!$event) {
        returnFalse();
    }

    $preferenze = array(
        'inaugurazione' => $req->post('inaugurazione') === 'true' ? 1 : 0,
        'conversazioni' => $req->post('conversazione') === 'true' ? 1 : 0,
        'notifiche'     => $req->post('notifiche') === 'true' ? 1 : 0,
        'preferiti'     => $req->post('preferiti') === 'true' ? 1 : 0
    );
    $types      = PreferenceType::all();

    Preference::table()->delete(array(
        'id_user'  => $user->id_user,
        'id_event' => $event->id_event
    ));

    foreach ($types as $t) {
        $pref = new Preference();
        $pref->id_user    = $user->id_user;
        $pref->id_event   = $event->id_event;
        $pref->preference = $t->description;
        $pref->value      = $preferenze[$t->description];
        $pref->save();
    }

    returnTrue();
});


/**********************************************
 * API DI RITORNO PREFERENZE UTENTE
 **********************************************/
$app->get('/preferences/:evento', function ($evento) use ($app) {
    if (!isset($_SESSION['logged'])) {
        returnFalse();
    }

    $req = $app->request;

    $user  = User::find_by_id_user($_SESSION['logged']);
    $event = Event::find_by_permalink($evento);

    if (!$event) {
        returnFalse();
    }

    $preferenze = $req->post('preferenze');
    $types      = PreferenceType::all();

    $alls = Preference::find('all', array(
        'conditions' => 'id_user = ' . $user->id_user . ' and id_event = ' . $event->id_event
    ));

    $resp = array();

    foreach ($alls as $a) {
        $resp[$a->preference] = $a->value;
    }

    foreach ($types as $t) {
        if (!isset($resp[$t->description])) {
            $resp[$t->description] = 0;
        }
    }

    echo json_encode($resp);
});

$app->post('/infoopera', function () use ($app) {
    $req = $app->request;

    $rectelephone = $req->post('rectelephone');
    $dettagli = $req->post('dettagli');
    $maggioriinfo = $req->post('maggioriinfo');
    $acquisto = $req->post('acquisto');
    $prestito = $req->post('prestito');

    returnTrue();
});

$app->post('/inviagenerali', function () use ($app) {
    $req = $app->request;

    $nomecognome = $req->post('nomecognome');
    $richiesta = $req->post('richiesta');
    $email = $req->post('email');
    $telefono = $req->post('telefono');

    $subject = 'Richiesta di informazioni generali';
    $html = "Nome e cognome: " . $nomecognome . "\n" .
            "E-Mail: " . $email . "\n" .
            "Telefono: " . $telefono . "\n" .
            "Richiesta: \n" . $richiesta;
    $from = "From: Info Artfoundtrust.com <" . SENDER_MAIL . ">\r\n";

    mail(INFO_MAIL, $subject, $html, $from);

    echo json_encode(array(
        'status' => 'OK',
        'text' => $html
    ));
});

$app->post('/inviavisita', function () use ($app) {
    $req = $app->request;

    $user  = User::find_by_id_user($_SESSION['logged']);

    $nomecognome = $user->name;
    $richiesta = $req->post('richiesta');
    $email = $user->email;

    $subject = 'Richiesta di visita esclusiva';
    $html = "Nome e cognome: " . $nomecognome . "\n" .
            "E-Mail: " . $email . "\n" .
            "Richiesta: \n" . $richiesta;
    $from = "From: Info Artfoundtrust.com <" . SENDER_MAIL . ">\r\n";

    mail(INFO_MAIL, $subject, $html, $from);

    echo json_encode(array(
        'status' => 'OK',
        'text' => $html
    ));
});

$app->run();
