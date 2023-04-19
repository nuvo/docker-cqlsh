FROM python:2.7

WORKDIR /scripts

ENV CQLVERSION="3.4.6" \
    CQLSH_HOST="cassandra" \
    CQLSH_PORT="9042"

RUN pip install -Ivq cqlsh==6.0.0 \
    pip install futures \
    && echo 'alias cqlsh="cqlsh --cqlversion ${CQLVERSION} $@"' >> /.bashrc \
    && mkdir /.cassandra

COPY ["entrypoint.sh", "/usr/local/bin"]

USER nobody

CMD ["entrypoint.sh"]