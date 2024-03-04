#! /usr/bin/bash

err() {
  echo
  echo -e "\033[1;31m [$(date +'%Y-%m-%dT%H:%M:%S%z')]: $* \033[0m" >&2
  echo
}

success() {
  echo
  echo -e "\033[1;32m $* \033[0m" >&1
  echo
}

install() {
    if [ -f .env.example ]; then

        if [ -f $(dirname $(readlink -f $0))/.env ]; then
            rm $(dirname $(readlink -f $0))/.env
            sleep 0.5;
            echo ".env file removed"
        fi
        cp -f $(dirname $(readlink -f $0))/.env.example $(dirname $(readlink -f $0))/.env

    else
        err ".env.example file not found!"
        exit 1001
    fi
    
    #install composer and remove it if the dependencies instalation is complete
    docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(dirname $(readlink -f $0)):/var/www/html" \
    -w /var/www/html \
    laravelsail/php83-composer:latest \
    composer install --ignore-platform-reqs


    if [ ! -L $(dirname $(readlink -f $0))/public/storage ]; then
        echo "Creating storage symlink"
        docker compose exec -i app php artisan storage:link
    fi

    docker compose exec -i app php artisan key:generate


    success "Application has been successfully installed😊"
    sleep 0.75
}

while [ $# -gt 0 ]; do
    key="$1"
    case $key in
    -i | --install)
        install
        exit 0
        ;;
    *)
        err "Invalid option: $key"
        exit 1001
        ;;
    esac
    shift
done
