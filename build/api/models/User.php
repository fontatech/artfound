<?php

class User extends ActiveRecord\Model {
    static $table_name = 'af_users';

    public function login () {
        $_SESSION['logged'] = $this->id_user;
    }

    public static function getLoggedUser () {
        if (!isset($_SESSION['logged'])) {
            return false;
        } 

        return User::find_by_id_user($_SESSION['logged']);
    }
}
