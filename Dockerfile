FROM python:3.7.7-slim-stretch

# DIRECTORY STRUCTURE
WORKDIR /home/
RUN mkdir /chinchalinchin
WORKDIR /home/chinchalinchin/
RUN mkdir core && mkdir navigation && mkdir frontend

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

## BACKEND APPLICATION
COPY /chinchalinchin/core/ /home/chinchalinchin/core/
COPY /chinchalinchin/navigation/ /home/chinchalinchin/navigation/
COPY /chinchalinchin/manage.py /home/chinchalinchin/manage.py
COPY /chinchalinchin/debug.py /home/chinchalinchin/debug.py

# FRONTEND APPLICATION
# COPY /frontend/  /home/frontend/

# START UP SCRIPTS
WORKDIR /home/chinchalinchin/
COPY /scripts/init-app.sh /home/chinchalinchin/init-app.sh

CMD ["bash", "./init-app.sh"]