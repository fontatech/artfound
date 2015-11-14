<?php

class EventDocument extends ActiveRecord\Model {
    static $table_name = 'af_event_documents';

    public function getName ($lang_id) {
        $tr = Translation::find_by_id_translation_and_id_language($this->id_title, $lang_id);
        return $tr->content;
    }
}
