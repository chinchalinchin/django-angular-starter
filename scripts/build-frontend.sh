SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container.sh'
source "$SCRIPT_DIR/util/logging.sh"

cd $SCRIPT_DIR/../frontend/

log 'Installing Dependencies' $SCRIPT_NAME
npm install

log 'Compiling Angular Artifacts' $SCRIPT_NAME
ng build --prod --output-hashing none