SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-app.sh'
source "$SCRIPT_DIR/util/logging.sh"

# arguments: container or local
    # local: start the application in development mode
    # container: start the application in production mode

# Pre-application Configuraiton

if [ "$1" == "local" ]
then
    log 'Initializing Environment' $SCRIPT_NAME
    source $SCRIPT_DIR/init-local-env.sh

    log 'Building Frontend' $SCRIPT_NAME
    bash $SCRIPT_DIR/build-frontend.sh

    log 'Navigating To Project Root' $SCRIPT_NAME
    cd $SCRIPT_DIR/../app/
fi

log 'Migrating Django Models' $SCRIPT_NAME
python manage.py migrate

log 'Collecting Static Files' $SCRIPT_NAME
python manage.py collectstatic --noinput

log 'Debugging Django Settings' $SCRIPT_NAME
python debug.py

# Entrypoint for application. Configure for whatever environment you are deploying
# the application into, e.g. a cloud service or a local development server.

if [ "$1" == "local" ]
then
    log 'Starting Django App In Development Mode' $SCRIPT_NAME
    python manage.py runserver 8000
fi
if [ "$1" == "container" ]
then
    log 'Binding WSGI App to Gunicorn On 0.0.0.0:8000' $SCRIPT_NAME 
    gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
fi