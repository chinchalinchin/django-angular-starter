SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-app.sh'
source "$SCRIPT_DIR/util/logging.sh"


log '> Migrating Django Models' $SCRIPT_NAME
python manage.py migrate

log '> Debugging Django Settings' $SCRIPT_NAME
python debug.py

# Entrypoint for application. Configure for whatever environment you are deploying
# the application into, e.g. a cloud service or a local development server.

if [ "$ENVIRONMENT" == "container" ]
then
    log '--> Collecting Static Files' $SCRIPT_NAME
    python manage.py collectstatic --noinput
    log '--> Binding WSGI App to Gunicorn On 0.0.0.0:8000' $SCRIPT_NAME 
    gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
fi