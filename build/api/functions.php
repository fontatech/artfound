<?php

function returnFalse () {
    echo json_encode(array(
        'status' => 'KO'
    ));
    die();
}

function returnTrue () {
    echo json_encode(array(
        'status' => 'OK'
    ));
    die();
}
