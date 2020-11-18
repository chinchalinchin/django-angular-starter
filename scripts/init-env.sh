SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-env.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ -f "$SCRIPT_DIR/../app.env" ]
then
    set -o allexport
    source $SCRIPT_DIR/../app.env
    set +o allexport
else
    cd $SCRIPT_DIR/..
    touch app.env
    log 'Please configure the \e[4mapp.env\e[0m file. See documentation for more information' $SCRIPT_NAME
fi