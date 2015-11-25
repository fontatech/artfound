<?php
class EventSpeaker extends ActiveRecord\Model {
    static $table_name = 'af_event_speakers';

    public function getSpeaker () {
        return Speaker::find_by_id_speaker($this->id_speaker);
    }
}
