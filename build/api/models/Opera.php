<?php

class Opera extends ActiveRecord\Model {
    static $table_name = 'af_artworks';
    static $primary_key = 'id_artwork';

    public function getImages () {
        return OperaImage::find('all', array(
            'conditions' => 'id_artwork = ' . $this->id_artwork
        ));
    }

    public function getTitle ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_title, $lang_id);
        return $tr->content;
    }

    public function getDescription ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_description, $lang_id);
        return $tr->content;
    }

    public function getArtist () {
        $art = Artist::find_by_id_artist($this->id_artist);
        return $art;
    }

    public function getIsDisponible ($lang_id) {
        $status = OperaStatus::find_by_id_status($this->id_status);

        return $status->getText($lang_id);
    }
}
