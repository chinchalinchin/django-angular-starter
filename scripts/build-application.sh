SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-application.sh'
source "$SCRIPT_DIR/util/logging.sh"

log 'Initializing Local Environment' $SCRIPT_NAME
source $SCRIPT_DIR/init-local-env.sh

cd $SCRIPT_DIR/../app/
log "Navigating to Django  Project Root: $(pwd)" $SCRIPT_NAME

log 'Installing Backend Dependencies' $SCRIPT_NAME
pip install -r requirements.txt
    
cd $SCRIPT_DIR/../frontend/
log "Navigating to Angular Project Root: $(pwd)" $SCRIPT_NAME

log 'Installing Frontend Dependencies' $SCRIPT_NAME
npm install