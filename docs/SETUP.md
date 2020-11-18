[<< ReadMe](../README.md) | [Application >>](APPLICATION.md)

# Setup

## Prerequisites

This project can be run locally, but it has also been containerized for ease of development. See below for the links to the necessary software needed to build and run the application. 

<b>Local Development</b><br>
<i>Required</i>

- [Python](https://www.python.org/downloads/)
- [NodeJs](https://nodejs.org/en/download/)

<i>Optional, but highly recommended</i>

- [Docker](https://www.docker.com/products/docker-desktop)
- [Git For Windows](https://git-scm.com/download/win)

<i>Optional, but recommended for local development</i>

- [PostgreSQL](https://www.postgresql.org/download/)

## Setup From Scratch

Below are the steps taken to setup this project. The code in this repository is the result of taking these steps; this document only serves as a record of the process. If you do not wish to start the project from scratch, skip this page.

1. Set up Django Project and a Django app within project

> django-admin startproject app<br>
> cd app<br>
> django-admin startapp navigation<br>

2. Configure Django settings. <b>DATABASES</b> should be set to <i>django.db.backends.postgresql</i> and the credentials configured through environment variables. The web application Docker image is orchestrated in the <i>docker-compose.yml</i> with a <b>postgres</b> database image. The credentials are loaded in through environment variables set in the <i>app.env</i> file. Both images, the Django app and the database image, read in the database credentials through this file. 

Static file properties, <b>STATIC_ROOT</b>, <b>STATIC_DIRS</b> and <b>STATIC_URL</b>, should be set properly. In addition, in order for the WSGI application on the <b>Gunicorn</b> server to serve static files with the Django framework, the Whitenoise middleware needs to be included in the MIDDLEWARE property.

Place any new Django apps within the INSTALLED_APPS setting as they are created.

3. Make the <i>navigation</i> app within the Django project and have it serve up an HTML template view that loads in Angular build files through script tags in the HTML. Template <i>/navigation/template/home.html</i> shows the necessary HTML markup to load in Angular files. In addition, the HTML also loads Bootstrap from an external source. 

Ensure the <i>core</i> app within the Django project routes requests to the <i>navigation</i>app. Changes to the <i>/core/urls.py/</i> and <i>/navigation/urls.py</i> need to be made.

4. Create Angular project

> ng new frontend

5. Open the <i>angular.json</i> within generated project and set <b>architect.build.options.outpathPath</b> == <i>"/../app/static/"</i>. This will ensure the Angular build files are outputted into the static directories configured to be served within the Django HTML templates found within the <i>/app/navigation/templates/</i> directory.

[<< ReadMe](../README.md) | [Application >>](APPLICATION.md)