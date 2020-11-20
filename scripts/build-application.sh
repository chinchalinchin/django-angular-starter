SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-application'
nl=$'\n'
SCRIPT_DES="This script installs the application dependencies on your local ${nl}\
   environment for the frontend Angular app and the backend Django app,${nl}\
   in addition to collecting static files and migrating models to the ${nl}
   database configured in the \e[3mlocal.env\e[0m environment file. ${nl}
   After running this script you can start the application on your ${nl}\
   local machine by running the \e[3mpython manage.py runserver\e[0m or by${nl}\
   deploying the WSGI application onto a compatible server, such as${nl}\
   \e[2mgunicorn\e[0m or \e[2mmod_wsgi\e[0m.${nl}${nl}"
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    source "$SCRIPT_DIR/util/local-env.sh"

    cd $SCRIPT_DIR/../app/
    log "Navigating to Django Project Root: $(pwd)" $SCRIPT_NAME

    log 'Installing Backend Dependencies' $SCRIPT_NAME
    pip install -r requirements.txt
        
    cd $SCRIPT_DIR/../frontend/
    log "Navigating to Angular Project Root: $(pwd)" $SCRIPT_NAME

    log 'Installing Frontend Dependencies' $SCRIPT_NAME
    npm install

    log 'Transpiling Angular Artifacts' $SCRIPT_NAME
    ng build --prod --output-hashing none

    cd $SCRIPT_DIR/../app/
    log "Navigating To Django Project Root: $(pwd)" $SCRIPT_NAME

    log 'Collecting Static Files' $SCRIPT_NAME
    python manage.py collectstatic --noinput

    log 'Migrating Models to Database' $SCRIPT_NAME
    python manage.py migrate
fi