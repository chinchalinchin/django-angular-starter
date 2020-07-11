FROM python:3.7.7-slim-stretch

# DIRECTORY STRUCTURE
WORKDIR /home/
RUN mkdir /chinchalinchin
WORKDIR /home/chinchalinchin/
RUN mkdir core && mkdir navigation && mkdir frontend && mkdir util

# APP DEPENDENCIES
RUN apt-get update -y && apt-get install -y curl wait-for-it

## BACKEND DEPENDENCIES
COPY /chinchalinchin/requirements.txt /home/chinchalinchin/requirements.txt
WORKDIR /home/chinchalinchin/
RUN pip install -r requirements.txt

## FRONTEND DEPENDENCIES
WORKDIR /home/frontend/
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs
RUN npm install -g @angular/cli@8.2.0
COPY /frontend/  /home/frontend/
RUN npm install
RUN ng build --prod --output-hashing none

## BACKEND APPLICATION
COPY /chinchalinchin/core/ /home/chinchalinchin/core/
COPY /chinchalinchin/navigation/ /home/chinchalinchin/navigation/
COPY /chinchalinchin/manage.py /home/chinchalinchin/manage.py
COPY /chinchalinchin/debug.py /home/chinchalinchin/debug.py

# START UP SCRIPTS
WORKDIR /home/chinchalinchin/
COPY /scripts/init-app.sh /home/chinchalinchin/init-app.sh
COPY /scripts/util/logging.sh /home/chinchalinchin/util/logging.sh

CMD ["bash", "./init-app.sh"]