FROM python:latest

RUN mkdir -p /home/chinchalinchin
COPY /chinchalinchin/requirements.txt /home/chinchalinchin
COPY /scripts/init-app.sh /home/chinchalinchin/init-app.sh

WORKDIR /home/chinchalinchin/
RUN pip install -r requirements.txt

CMD ["bash", "./init-app.sh"]