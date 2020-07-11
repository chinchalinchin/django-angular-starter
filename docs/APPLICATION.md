### Starting the Application

Run from the root directory either,

> docker-compose up

Or to clean up the application beforehand (i.e. remove <i>/static/</i> files and <i>/node_modules/</i> dependencies) and build a fresh image, invoke the BASH script from the project root directory,

> /scripts/build-app.sh

This will call <i>docker-compose</i>. The <i>docker-compose.yml</i> builds an image of a Django web application and networks it with a <b>postgres</b> image. During the build of the web application image, the Angular frontend application is built and stored within the <i>/static/</i> directory of the Django app. Gunicorn, a python web server, wraps the WSGI application and serves the static files. The web application container is exposed locally at <i>localhost:8000</i>. 

[< Setup](docs/SETUP.md)