FROM php:8.4-alpine

WORKDIR /app

EXPOSE 8080/tcp

CMD [ "php", "./src/http-server.php" ]
