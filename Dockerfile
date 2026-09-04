FROM alpine:3.19

RUN apk add --no-cache bash coreutils iputils bind-tools curl

WORKDIR /app
COPY app/ /app/

RUN chmod +x /app/*.sh

ENTRYPOINT ["bash", "/app/diagnostic.sh"]
