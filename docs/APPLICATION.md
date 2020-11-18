[<< Setup](SETUP.md) | [Environment >>](ENVIRONMENT.md)

# Starting the Application

## Local Development

First, you must ensure the frontend has been built and the artifacts deposited in the <i>/static/</i> folder in the backend. To do this, run the command,

> ng build --prod --output-hashing none

You <b>must</b> run the Angular build with the <i>--output-hashing</i> flag, to suppress the randomized naming convention for Angular transpiled javascripts. In order for the Django backend to locate the Angular artifacts, the names of files must be consistent across builds.

Once the Angular artifacts are outputted into the <i>/app/static/</i> folder, the application can be brought up into the test environment with the typical Django commands, such as,

> python manage.py runserver

Keep in mind, the application when running in development mode on your local host has not been configured to connect to any datasources or databases. The application has been pre-configured to run with a <b>postgres</b> database image in a containerized environment, which enhances the application's functionality. Because of this, local development mode is only recommended for simple tasks, such as frontend testing, debugging, etc, unless you intend to setup a SQL server on your local machine.

## Docker Development 

The <i>Dockerfile</i> and <i>docker-compose</i> found in the root folder of this project provide a containerized version of this application that can be built with a single command, assuming you have installed <b>Docker</b>. Run from the root directory either,

> docker-compose up

Or to clean up the application beforehand (i.e. remove <i>/static/</i> files and <i>/node_modules/</i> dependencies left over from development, clear the Docker cache, remove any dangling images from previous failed builds, etc.) and build a fresh image, invoke the BASH script from the project root directory,

> /scripts/build-app.sh

This will call <i>docker-compose</i>, but also perform some side-tasks that prevent your computer from blowing up. 

The <i>docker-compose.yml</i> builds and runs an image of a Django web application and networks it with a <b>postgres</b> container. During the build of the web application image, the Angular frontend application is built and stored within the <i>/static/</i> directory of the Django app. <b>Gunicorn</b>, a python web server, wraps the WSGI application and serves the static files. The web application container is exposed locally at <i>localhost:8000</i>. 

The <i>/scripts/init-app.sh</i> executes inside the container, once the application and frontend have been built. The execution can be configured by editing the environment variable <b>ENVIRONMENT</b> and the script, accordingly. The script currently initializes the application so that requests to <i>localhost</i> are routed into the container. In the production, this script should include the correct initialization procedure for whatever environment the application is in, i.e. which cloud.

Note: both the web application container and <b>postgres</b> container are configured by the variables defined in the <i>app.env</i> file. 

[<< Setup](SETUP.md) | [Environment >>](ENVIRONMENT.md)

