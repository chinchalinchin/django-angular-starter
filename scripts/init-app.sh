SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-app.sh'
source "$SCRIPT_DIR/util/logging.sh"

# TODO: Migrations

timestamped_print '> Debugging Django Settings <' $SCRIPT_NAME
python debug.py

if [ "$ENVIRONMENT" == "container" ]
then
    timestamped_print '--> Collecting Static Files' $SCRIPT_NAME
    python manage.py collectstatic --noinput
    timestamped_print '--> Binding WSGI App to Gunicorn On 0.0.0.0:8000' $SCRIPT_NAME 
    gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
fi