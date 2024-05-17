### Les commandes à lancer pour créer les images et les containers :
# création du réseau
# docker network create sf_network

# création des images du projet (symfony) et de la bdd (mariadb)
# docker build -t project_image .
# docker container run --name project_db --network sf_network mariadb
# [ERROR] [Entrypoint]: Database is uninitialized and password option is not specifiedYou need to specify one of MARIADB_ROOT_PASSWORD,
# docker container run --rm -e MARIADB_ROOT_PASSWORD=password --name project_db --network sf_network mariadb

# docker container run --name project_app --rm -p 8090:80 --network sf_network project_image

# création du container phpmyadmin (à reprendre)
# docker container run --name phpmyadmin -d --link db_sf:db -p 8080:80 --network sf_network phpmyadmin

# création des containeurs de mail
# docker container run --name project_mail --rm -p 1025:80 --network sf_network project_image

# erreur (en cours) : AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.22.0.4. Set the 'ServerName' directive globally to suppress this message
# marche tjrs pas malgré modification via sudo nano /etc/apache2/apache2.conf (apachectl configtest renvoie Syntax OK)

# lancement du projet via docker-compose.yml
# docker-compose up -d

FROM php:7.4-apache

#tentative de regler le bug d'accès au dossier mysql qui se crée à chaque docker-compose up -d
RUN #chmod 777 ./mysql

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

RUN docker-php-ext-install pdo pdo_mysql
RUN a2enmod rewrite


WORKDIR /var/www/html
COPY . .

EXPOSE 85

CMD ["apache2-foreground"]


