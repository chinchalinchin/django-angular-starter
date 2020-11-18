[<< Application](APPLICATION.md) | [Appendix >>](ENVIRONMENT.md)

# Application Environment

The <i>app.env</i> file located in the project root directory defines several environment variables that need to be set in order for the application to run, either locally or in a container. The Django app requires these variables to populate various settings in the <i>/app/core/settings.py</i> configuration file. In addition, the Dockerfile uses several of the variables to control the dependency versions. Every <i>app.env</i> should contain the following variables,

 - ENVIRONMENT
 - SECRET_KEY
 - ANGULAR_VERSION
 - NODE_VERSION
 - PYTHON_VERSION
 - POSTGRES_HOST
 - POSTGRES_PORT
 - POSTGRES_DB
 - POSTGRES_USER
 - POSTGRES_PASSWORD

The function of these variable should be relatively self-explanatory, but to be as verbose as possible, so there is no confusion, the following list explains the variables and their use in greater detail.

### ENVIRONMENT, SECRET_KEY

TODO: explain

### ANGULAR_VERSION, NODE_VERSION, PYTHON_VERSION

TODO: explain

### POSTGRES_HOST, POSTGRES_PORT, 

TODO: explain

You can load these variables into your current terminal session by leveraging the <i>init-env.sh</i> shell script,

> source PROJECT_ROOT/scripts/init-env.sh

If running locally with a local database, you should always load in your environment variables before running

> python manage.py runserver

so the <i>/app/core/settings.py</i> database connection properties can be configured properly. By contrasting, when running in a Dockerized environment, these variables are automatically loaded in the container environment through the <i>docker-compose.yml</i>'s <b>env_file<b> attribute.

[<< Application](APPLICATION.md) | [Appendix >>](ENVIRONMENT.md)