SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='env'
source "$SCRIPT_DIR/logging.sh"

# ARGUMENT: whatever environment's env vars you initializing. Must have a 
# corresponding .env file in the /env/ directory. 

log "Checking \e[3m$1.env\e[0m File Configuration" $SCRIPT_NAME   
if [ -f "$SCRIPT_DIR/../../env/$1.env" ]
then
    log 'Initializing Environment...' $SCRIPT_NAME
    set -o allexport
    source $SCRIPT_DIR/../../env/$1.env
    set +o allexport
    log 'Environment Initialized' $SCRIPT_NAME
else
    touch $SCRIPT_DIR/../../env/$1.env
    cp $SCRIPT_DIR/../../env/.sample.env $SCRIPT_DIR/../../env/l$1.env
    log "Please configure the \e[3m$1.env\e[0m file and then re-invoke this script.\
         See documentation for more information" $SCRIPT_NAME
    exit 0
fi