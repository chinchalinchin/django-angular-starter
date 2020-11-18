# VERSION CONTROL
FROM python:3.7.7-slim-stretch
ENV ANGULAR_VERSION=10.2
ENV NODE_VERSION=14
# TODO: Figure out how to pass in versions through the ARG command and docker-compose.yml 
#       used in conjunction.

# DIRECTORY STRUCTURE
WORKDIR /home/
RUN mkdir /app
WORKDIR /home/app/
RUN mkdir core && mkdir navigation && mkdir frontend && mkdir util

# APP DEPENDENCIES
RUN apt-get update -y && apt-get install -y curl wait-for-it

## BACKEND DEPENDENCIES
COPY /app/requirements.txt /home/app/requirements.txt
WORKDIR /home/app/
RUN pip install -r requirements.txt

## FRONTEND DEPENDENCIES
WORKDIR /home/frontend/
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs
RUN npm install -g @angular/cli@${ANGULAR_VERSION}
COPY /frontend/  /home/frontend/
RUN npm install
RUN ng build --prod --output-hashing none

## BACKEND APPLICATION
COPY /app/core/ /home/app/core/
COPY /app/navigation/ /home/app/navigation/
COPY /app/manage.py /home/app/manage.py
COPY /app/debug.py /home/app/debug.py

# START UP SCRIPTS
WORKDIR /home/app/
COPY /scripts/bootstrap.sh /home/app/bootstrap.sh
COPY /scripts/util/logging.sh /home/app/util/logging.sh

CMD ["bash", "./bootstrap.sh", "container"]