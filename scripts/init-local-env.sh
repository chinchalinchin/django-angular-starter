SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-env.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ -f "$SCRIPT_DIR/../env/local.env" ]
then
    set -o allexport
    source $SCRIPT_DIR/../local.env
    set +o allexport
else
    touch $SCRIPT_DIR/../env/local.env
    cp $SCRIPT_DIR/../env/.sample.env $SCRIPT_DIR/../env/local.env
    log 'Please configure the \e[4mlocal.env\e[0m file and then re-invoke this script. See documentation for more information' $SCRIPT_NAME
fi

# TODO: check if node, angular cli and python are installed