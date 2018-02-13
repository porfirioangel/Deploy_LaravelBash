<?php
    $info = file_get_contents('php://input');
    $data = json_decode($info, true);

    if ($data) {
        exec("sh /home/ingsoftware/scripts/laravel_deploy.sh " .
            $data["repository"]["git_ssh_url"] . " " .
            $data["repository"]["name"] . " >> hooklog 2>&1", $res);
    } else {
        echo "No se recibieron datos en la petición";
    }
?>