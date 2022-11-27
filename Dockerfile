FROM alpine:3.14
RUN apk add --no-cache openssh

RUN adduser -D --home /home/git -g git --shell /bin/sh git
RUN sed -i s/git:!/"git:*"/g /etc/shadow

RUN apk add --no-cache git

EXPOSE 22
COPY rootfs /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

