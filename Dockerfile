# eks version
FROM alpine/k8s:1.16.8

RUN apk add --update \
        coreutils \
        py-pip

LABEL maintainer="Rokhun Jung <j.rokhun@gmail.com>"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]