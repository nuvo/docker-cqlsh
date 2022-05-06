FROM python:2.7-alpine3.8

WORKDIR /scripts

ENV CQLVERSION="3.4.5" \
    CQLSH_HOST="cassandra" \
    CQLSH_PORT="9042"

RUN pip install -Ivq cqlsh==6.0.0 \
    && apk add --no-cache bash \
    && echo 'alias cqlsh="cqlsh --cqlversion ${CQLVERSION} $@"' >> /.bashrc \
    && mkdir /.cassandra

COPY ["entrypoint.sh", "/usr/local/bin"]

USER nobody

CMD ["entrypoint.sh"]
