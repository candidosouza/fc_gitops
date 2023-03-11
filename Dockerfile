FROM python:3.11.2 AS build

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONFAULTHANDLER=1

RUN useradd -ms /bin/bash python && chown -R python:python /var/log
USER python
WORKDIR /home/python/app
ENV PATH $PATH:/home/python/.local/bin
COPY . .
ENV PATH $PATH:/home/python/.local/bin

# multstage build
FROM python:3.11.2-slim

ENV PYTHONUNBUFFERED 1

WORKDIR /app
RUN apt update && apt install --no-install-recommends -y libpq-dev gcc python3-dev
ADD . /app/
COPY --from=build /home/python/app .
RUN apt-get autoremove -y && \
    apt-get clean

ENTRYPOINT ["./.docker/entrypoint.sh"]