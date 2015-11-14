<?php

class OperaStatus extends ActiveRecord\Model {
    static $table_name  = 'af_artwork_statuses';
    static $primary_key = 'id_status';

    public function getText ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_description, $lang_id);
        return $tr->content;
    }
}
