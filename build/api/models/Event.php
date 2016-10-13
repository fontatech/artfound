<?php

class Event extends ActiveRecord\Model {
    static $table_name = 'af_events';
    static $primary_key = 'id_event';

    public function getType () {
        $now   = strtotime(date('Y-m-d'));
        $start = strtotime(substr($this->start_date->format('Y-m-d'), 0, 10));
        $end   = strtotime(substr($this->end_date->format('Y-m-d'), 0, 10));

        if ($now >= $start && $now <= $end) {
            return 'PRESENT';
        }

        if ($now < $start) {
            return 'FUTURE';
        }

        return 'PAST';
    }

    public function getTitle($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_event_name, $lang);
        return $tr->content;
    }

    public function getDescr($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_event_description, $lang);
        return $tr->content;
    }

    public function getLangDate($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_data, $lang);
        return $tr->content;
    }

    public function getYear() {
        return $this->start_date->format('Y');
    }

    public function getEsposizione($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_esposizione, $lang);
        return $tr->content;
    }

    public function getInaugurazione($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_inaugurazione, $lang);
        return $tr->content;
    }

    public function getConversazione($lang) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_conversazione, $lang);
        return $tr->content;
    }

    public function getArtisti () {
        $artisti = EventArtist::find('all', array(
            'conditions' => 'id_event = ' . $this->id_event
        ));
        $resp = array();

        foreach ($artisti as $a) {
            $resp[] = array(
                'name' => $a->getArtista()->name,
                'permalink' => '/artista/' . $a->getArtista()->permalink
            );
        }

        return $resp;
    }

    public function getOpere ($lang_id) {
        $opere = EventArtwork::find('all', array(
            'conditions' => 'id_event = ' . $this->id_event
        ));
        $resp  = array();

        $index = 1;

        foreach ($opere as $o) {
            $opera = Opera::find_by_id_artwork($o->id_artwork);

            foreach ($opera->getImages() as $i) {
                $resp[] = array(
                    'img'          => '/upload/opere/' . $i->image,
                    'id'           => $index,
                    'titolo'       => $opera->getTitle($lang_id),
                    'artista'      => $opera->getArtist()->name,
                    'descrizione'  => $opera->getDescription($lang_id),
                    'misure'       => $opera->measurements,
                    'artpermalink' => '/artista/' . $opera->getArtist()->permalink
                );

                $index++;
            }
        }

        return $resp;
    }

    public function getSpeakers ($lang_id) {
        $speakers = EventSpeaker::find('all', array(
            'conditions' => 'id_event = ' . $this->id_event
        ));

        $resp = array();
        $index = 1;

        foreach ($speakers as $s) {
            $resp[] = array(
                'id'          => $index,
                'name'        => $s->getSpeaker()->name,
                'description' => $s->getSpeaker()->getAbstract($lang_id)
            );

            $index++;
        }

        return $resp;
    }

    public function getDocuments ($lang_id) {
        $docs = EventDocument::find('all', array(
            'conditions' => 'id_event = ' . $this->id_event
        ));

        $resp = array();

        foreach ($docs as $d) {
            $resp[] = array(
                'file' => '/upload/documenti/' . $d->path,
                'name' => $d->getName($lang_id)
            );
        }

        return $resp;
    }
}
