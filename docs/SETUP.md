# Setup

## Prerequisites

[Docker](https://docs.docker.com/get-docker/)<br>
[Git for Windows](https://git-scm.com/download/win)<br>

## Steps

Below are the steps taken to setup this project. The code in this repository is the result of taking these steps; this document only serves as a record of the process. If you do not wish to start the project from scratch, skip this page.

1. Set up Django Project and a Django app within project

> django-admin startproject chinchalinchin<br>
> cd chinchalinchin<br>
> django-admin startapp navigation<br>

2. Configure Django settings. <b>DATABASES</b> should be set to <i>django.db.backends.postgresql</i> and the credentials configured through environment variables. The web application is orchestrated in <i>docker-compose</i> with a postgresql database image. The credentials are loaded in through environment variables set in the <i>local.env</i> file. Both images, the Django app and the database image, read in the database credentials through this file. 

Static file properties, <b>STATIC_ROOT</b>, <b>STATIC_DIRS</b> and <b>STATIC_URL</b>, should be set properly. In addition, in order for the WSGI application on the Gunicorn server to serve static files with the Django framework, the Whitenoise middleware needs to be included in the MIDDLEWARE property.

Place any new Django apps within the INSTALLED_APPS setting as they are created.

Default configuration included.

3. Make the <i>navigation</i> app within the Django project serves up a HTML template view that loads in Angular build files through script tags in the HTML. Template <i>/navigation/template/home.html</i> shows the necessary HTML markup to load in Angular files. In addition, the HTML also loads Bootstrap from an external source. 

Ensure the <i>core</i> app within the Django project routes requests to the <i>navigation</i>app. Changes to the <i>/core/urls.py/</i> and <i>/navigation/urls.py</i> need to be made.

4. Create Angular project

> ng new frontend

5. Open the <i>angular.json</i> within generated project and set <b>architect.build.options.outpathPath</b> == <i>"/../chinchalinchin/static/"</i>. This will ensure the Angular build files are outputted into the static directories configured to be served within the Django web application.

6. 