FROM python:3.11.2

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONFAULTHANDLER=1

RUN useradd -ms /bin/bash python && \
    chown -R python:python /var/log

USER python

WORKDIR /home/python/app

ENV PATH $PATH:/home/python/.local/bin

ENTRYPOINT ["./.docker/entrypoint.sh"]