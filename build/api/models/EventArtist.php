<?php

class EventArtist extends ActiveRecord\Model {
    static $table_name = 'af_event_artists';

    public function getArtista () {
        return Artist::find_by_id_artist($this->id_artist);
    }
}
