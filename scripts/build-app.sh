SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-app.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ -d "$SCRIPT_DIR/../chinchalinchin/static/" ]
then
    timestamped_print '--> Cleaning \e[4m/static/\e[0m Directory' $SCRIPT_NAME
    rm -r $SCRIPT_DIR/../chinchalinchin/static/
fi
if [ -d "$SCRIPT_DIR/../frontend/node_modules/" ]
then
    timestamped_print '--> Cleaning \e[4m/node_modules/\e[0m Directory' $SCRIPT_NAME
    rm -r $SCRIPT_DIR/../frontend/node_modules/
fi

timestamped_print '--> Building Application Image' $SCRIPT_NAME
docker-compose build

timestamped_print '--> Orchestrating Images' $SCRIPT_NAME
docker-compose up