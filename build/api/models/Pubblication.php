<?php

class Pubblication extends ActiveRecord\Model {
    static $table_name = 'af_pubblications';

    public function getTitle ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_title, $lang_id);
        return $tr->content;
    }

    public function getSubtitle ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_subtitle, $lang_id);
        return $tr->content;
    }

    public function getDescription ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_description, $lang_id);
        return $tr->content;
    }

    public function getDate ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_data, $lang_id);
        return $tr->content;
    }

    public function formatPrice () {
        return str_replace('.', ',', $this->price) . ' EUR';
    }
}
