SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='bootstrap.sh'
source "$SCRIPT_DIR/util/logging.sh"

# arguments: container or local
    # local: start the application in development mode
    # container: start the application in production mode

if [ "$1" == "local" ]
then
    log 'Initializing Local Environment' $SCRIPT_NAME
    source $SCRIPT_DIR/init-local-env.sh
fi

cd $SCRIPT_DIR/../frontend/
log "Navigating to Angular Project Root: $(pwd)" $SCRIPT_NAME

# APPLICATION BUILD
log 'Compiling Angular Artifacts' $SCRIPT_NAME
ng build --prod --output-hashing none

cd $SCRIPT_DIR/../app/
log "Navigating To Django Project Root $(pwd)" $SCRIPT_NAME

log 'Migrating Django Models' $SCRIPT_NAME
python manage.py migrate

log 'Collecting Static Files' $SCRIPT_NAME
python manage.py collectstatic --noinput

log 'Debugging Django Settings' $SCRIPT_NAME
python debug.py

# APPLICATION ENTRYPOINT
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