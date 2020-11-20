SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='env'

source $SCRIPT_DIR/env.sh

log 'Checking \e[3mlocal.env\e[0m File Configuration' $SCRIPT_NAME   
if [ -f "$SCRIPT_DIR/../../env/local.env" ]
then
    log 'Initializing Environment...' $SCRIPT_NAME
    set -o allexport
    source $SCRIPT_DIR/../../env/local.env
    set +o allexport
    log 'Environment Initialized' $SCRIPT_NAME
else
    touch $SCRIPT_DIR/../../env/local.env
    cp $SCRIPT_DIR/../../env/.sample.env $SCRIPT_DIR/../../env/local.env
    log 'Please configure the \e[3mlocal.env\e[0m file and then re-invoke this script. See documentation for more information' $SCRIPT_NAME
    exit 0
fi