#fichier permettant de créer l'image de l'app symfony

# image officielle du serveur apache sous ubuntu
FROM ubuntu/apache2:latest
WORKDIR /app
COPY docker .
RUN npm install
RUN symfony console doctrine:database:create

RUN docker run -p 1080:1080 --name maildev maildev/maildev
EXPOSE  80


##projet time:
## Nous renseignons dans l'instruction FROM le Tag de notre image qui servira de base à notre application
#FROM node:current-alpine3.15
## Nous allons copier nos fichiers sources du répertoire courant du fichier Dockerfile dans le repertoire /app/.
## C'est un répertoire qui sera créé dans l'image lorsque l'on va faire le build
#COPY . /app/
#RUN cd /app && npm install
#EXPOSE 8080
#WORKDIR /app
CMD ["symfony", "serve"]