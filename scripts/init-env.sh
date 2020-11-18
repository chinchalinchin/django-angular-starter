SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-env.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ -f "$SCRIPT_DIR/../app.env" ]
then
    set -o allexport
    source $SCRIPT_DIR/../app.env
    set +o allexport
else
    log 'Please create and configure the \e[4mapp.env\e[0m file' $SCRIPT_NAME
fi