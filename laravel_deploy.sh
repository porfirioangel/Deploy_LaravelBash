#!/bin/bash

REPO=$1
FOLDER=$2

cd /var/www/html/ZacatecasUp

if [ -d "$FOLDER" ]; then
    echo "Actualizando el repositorio $REPO..."
    echo ""
    cd $FOLDER
    git pull origin master
    echo "Terminado"
    echo ""
else
    echo "Clonando el repositorio $REPO..."
    echo ""
    git clone $REPO
    echo "Terminado"
    echo ""

    # TODO Configurar .env
fi

php artisan migrate:fresh --seed