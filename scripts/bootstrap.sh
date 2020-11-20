SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='bootstrap'
nl=$'\n'
SCRIPT_DES="This script is designed to start up the application server \e[3minside\e[0m${nl}\
   of the container created by the \e[1mDockerfile\e[0m in the project's root${nl}\
   directory. This script builds the Angular Javascript bundles,${nl}\
   collects all of the static files to be served by the \e[2mgunicorn\e[0m web ${nl}\
   server, and migrates Django's models to the database connection ${nl}\
   configured in the \e[3mcontainer.env\e[0m environment file."
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else

    ########################################################
    ## PRE-DEPLOYMENT CONTAINER TASKS 
    #######################################################
    cd $SCRIPT_DIR/../frontend/
    log "Navigating to Angular Project Root: $(pwd)" $SCRIPT_NAME

    log 'Transpiling Angular Artifacts' $SCRIPT_NAME
    ng build --prod --output-hashing none
    
    cd $SCRIPT_DIR/../app/
    log "Navigating To Django Project Root: $(pwd)" $SCRIPT_NAME

    log 'Collecting Static Files' $SCRIPT_NAME
    python manage.py collectstatic --noinput

    log 'Migrating Models to Database' $SCRIPT_NAME
    python manage.py migrate

    log 'Debugging Django Settings' $SCRIPT_NAME
    python debug.py
    #########################################################

    #########################################################
    ## CONTAINER APPLICATION ENTRYPOINT
    #########################################################
    log 'Binding WSGI App to Gunicorn On 0.0.0.0:8000' $SCRIPT_NAME 
    gunicorn core.wsgi:application --bind=0.0.0.0 --workers 3
    #########################################################

fi