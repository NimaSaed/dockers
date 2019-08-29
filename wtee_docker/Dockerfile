FROM alpine:latest

RUN apk add python3 && \
    pip3 install -U pip && \
    pip install wtee

EXPOSE 8080
WORKDIR /log
COPY ./start.sh /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
