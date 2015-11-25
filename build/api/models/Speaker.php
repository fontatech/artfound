<?php

class Speaker extends ActiveRecord\Model {
    static $table_name = 'af_speakers';
    static $primary_key = 'id_speaker';

    public function getAbstract ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_abstract, $lang_id);
        return $tr->content;
    }
}
