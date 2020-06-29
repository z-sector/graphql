FROM python:3.7
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY Pipfile Pipfile.lock /app/
RUN set -ex && pip install pipenv && pipenv install --system
COPY . /app/
