FROM vault:1.13.3

RUN apk update && apk add jq curl

COPY ./entrypoint.sh /entrypoint.sh
COPY ./init.sh /init.sh

ENTRYPOINT [ "/entrypoint.sh" ]