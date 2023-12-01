FROM node

COPY ./src /app
COPY ./entrypoint.sh /entrypoint.sh

WORKDIR /app

ENV Host=0.0.0.0

ENTRYPOINT [ "/entrypoint.sh" ]