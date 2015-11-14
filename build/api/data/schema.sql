-- Artfound Database schema

DROP DATABASE artfound;
CREATE DATABASE artfound;
USE artfound;


-- Tabella delle lingue disponibili
CREATE TABLE IF NOT EXISTS af_languages (
    id_language INT(11) AUTO_INCREMENT,
    shortname VARCHAR(5) NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella delle labels da tradurre
CREATE TABLE IF NOT EXISTS af_labels (
    id_label INT(11) AUTO_INCREMENT,
    text VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella delle traduzioni labels
CREATE TABLE IF NOT EXISTS af_label_translations (
    id_label INT NOT NULL,
    id_language INT NOT NULL,
    value TEXT,
    PRIMARY KEY(id_label, id_language),
    FOREIGN KEY (id_label) REFERENCES af_labels(id_label),
    FOREIGN KEY (id_language) REFERENCES af_languages(id_language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella utenti
CREATE TABLE IF NOT EXISTS af_users (
    id_user INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_user),
    UNIQUE KEY idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella delle traduzioni non labels
CREATE TABLE IF NOT EXISTS af_translations (
    id_translation INT(11),
    id_language INT(11) NOT NULL,
    content TEXT,
    PRIMARY KEY(id_translation, id_language),
    FOREIGN KEY (id_language) REFERENCES af_languages (id_language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella principale degli eventi
CREATE TABLE IF NOT EXISTS af_events (
    id_event INT(11) NOT NULL,
    curator_name VARCHAR(255) NOT NULL,
    main_image VARCHAR(255) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    permalink VARCHAR(255) NOT NULL,
    id_event_name INT(11) NOT NULL,
    id_event_description INT(11) NOT NULL,
    id_esposizione INT(11),
    id_inaugurazione INT(11),
    id_conversazione INT(11),
    id_data INT(11),
    is_visible TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY(id_event),
    INDEX (start_date),
    INDEX (end_date),
    INDEX (creation_date),
    INDEX (is_visible),
    FOREIGN KEY (id_event_name) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_event_description) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_inaugurazione) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_conversazione) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_esposizione) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_data) REFERENCES af_translations (id_translation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella dei relatori agli eventi
CREATE TABLE IF NOT EXISTS af_speakers (
    id_speaker INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    id_abstract INT(11) NOT NULL,
    PRIMARY KEY (id_speaker),
    INDEX (name),
    FOREIGN KEY (id_abstract) REFERENCES af_translations(id_translation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella degli artisti 
CREATE TABLE IF NOT EXISTS af_artists (
    id_artist INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    permalink VARCHAR(255),
    id_description_title INT(11) NOT NULL,
    id_description INT(11) NOT NULL,
    PRIMARY KEY (id_artist),
    INDEX (name),
    FOREIGN KEY (id_description_title) REFERENCES af_translations(id_translation),
    FOREIGN KEY (id_description) REFERENCES af_translations(id_translation)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella degli status dell'opera
CREATE TABLE IF NOT EXISTS af_artwork_statuses (
    id_status INT(11) NOT NULL AUTO_INCREMENT,
    id_description INT(11),
    PRIMARY KEY(id_status),
    FOREIGN KEY (id_description) REFERENCES af_translations(id_translation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella delle opere
CREATE TABLE IF NOT EXISTS af_artworks (
    id_artwork INT(11) NOT NULL AUTO_INCREMENT,
    id_artist INT(11) NOT NULL,
    measurements VARCHAR(255) NOT NULL,
    is_trust_artwork TINYINT(1) NOT NULL DEFAULT 0,
    id_status INT(11) NOT NULL,
    id_title INT(11) NOT NULL,
    id_description INT(11) NOT NULL,
    PRIMARY KEY(id_artwork),
    INDEX (is_trust_artwork),
    INDEX (id_artist),
    FOREIGN KEY (id_title) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_description) REFERENCES af_translations (id_translation),
    FOREIGN KEY (id_artist) REFERENCES af_artists(id_artist),
    FOREIGN KEY (id_status) REFERENCES af_artwork_statuses(id_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella delle immagini associate alle opere
CREATE TABLE IF NOT EXISTS af_artwork_images (
    id_artwork INT(11) NOT NULL,
    image VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_artwork,image),
    FOREIGN KEY (id_artwork) REFERENCES af_artworks(id_artwork)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella dei relatori associati agli eventi
CREATE TABLE IF NOT EXISTS af_event_speakers (
    id_event INT(11) NOT NULL,
    id_speaker INT(11) NOT NULL,
    PRIMARY KEY(id_event, id_speaker),
    FOREIGN KEY (id_event) REFERENCES af_events(id_event),
    FOREIGN KEY (id_speaker) REFERENCES af_speakers(id_speaker)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella delle opere associate ad un evento
CREATE TABLE IF NOT EXISTS af_event_artworks (
    id_event INT(11) NOT NULL,
    id_artwork INT(11) NOT NULL,
    PRIMARY KEY (id_event, id_artwork),
    FOREIGN KEY (id_artwork) REFERENCES af_artworks(id_artwork),
    FOREIGN KEY (id_event) REFERENCES af_events(id_event)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Tabella della documentazione associata ad un evento
CREATE TABLE IF NOT EXISTS af_event_documents (
    id_document INT(11) NOT NULL AUTO_INCREMENT,
    id_event INT(11) NOT NULL,
    path VARCHAR(255) NOT NULL,
    id_title INT(11) NOT NULL,
    PRIMARY KEY (id_document),
    FOREIGN KEY (id_event) REFERENCES af_events(id_event),
    FOREIGN KEY (id_title) REFERENCES af_translations(id_translation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--  Tabella delle pubblicazioni create
CREATE TABLE IF NOT EXISTS af_pubblications (
    id_pubblication INT(11) NOT NULL AUTO_INCREMENT,
    price FLOAT(10,2) NOT NULL,
    id_title INT(11) NOT NULL,
    id_subtitle INT(11) NOT NULL,
    id_description INT(11) NOT NULL,
    id_data INT(11) NOT NULL,
    image VARCHAR(255),
    creation_date TIMESTAMP,
    PRIMARY KEY(id_pubblication),
    INDEX (creation_date),
    FOREIGN KEY (id_title) REFERENCES af_translations(id_translation),
    FOREIGN KEY (id_subtitle) REFERENCES af_translations(id_translation),
    FOREIGN KEY (id_description) REFERENCES af_translations(id_translation),
    FOREIGN KEY (id_data) REFERENCES af_translations(id_translation)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella degli artisti presenti all'inaugurazione di un evento
CREATE TABLE IF NOT EXISTS af_event_artists (
    id_event INT(11) NOT NULL,
    id_artist INT(11) NOT NULL,
    PRIMARY KEY (id_event, id_artist),
    FOREIGN KEY (id_event) REFERENCES af_events (id_event),
    FOREIGN KEY (id_artist) REFERENCES af_artists (id_artist)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS af_preference_types (
    id_preference INT(11) NOT NULL AUTO_INCREMENT,
    description VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_preference)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabella delle preferenze utente
CREATE TABLE IF NOT EXISTS af_preferences (
    id_user INT(11) NOT NULL,
    id_event INT(11) NOT NULL,
    preference VARCHAR(15) NOT NULL,
    value TINYINT(1) NOT NULL,
    PRIMARY KEY(id_user,id_event,preference),
    FOREIGN KEY (id_user) REFERENCES af_users (id_user),
    FOREIGN KEY (id_event) REFERENCES af_events (id_event)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
