SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='init-local-env.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ -f "$SCRIPT_DIR/../env/local.env" ]
then
    set -o allexport
    source $SCRIPT_DIR/../local.env
    set +o allexport
else
    touch $SCRIPT_DIR/../env/local.env
    cp $SCRIPT_DIR/../env/.sample.env $SCRIPT_DIR/../env/local.env
    log 'Please configure the \e[3mlocal.env\e[0m file and then re-invoke this script. See documentation for more information' $SCRIPT_NAME
fi

if ! command -v python &> /dev/null
then
    log "Installing Python..." $SCRIPT_NAME
    apt-get install -y python3 python3-pip
fi

if ! command -v docker &> /dev/null
then 
    log "Installing Docker..." $SCRIPT_NAME
    apt-get install -y docker
fi

if ! command -v git &> /dev/null
then
    log "Installing Git..." $SCRIPT_NAME
    apt-get install git
fi

if ! command -v node &> /dev/null
then
    log "Installing Node..." $SCRIPT_NAME
    curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - apt-get install -y nodejs
fi

if ! command -v ng &> /dev/null
then
    log ">> Installing Angular CLI" $SCRIPT_NAME
    npm install -g @angular/cli@$ANGULAR_VERSION
fi
