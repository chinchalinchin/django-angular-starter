SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container'
nl=$'\n'
SCRIPT_DES="This script will rebundle the Angular front-end into new artifacts ${nl}\
   while the container is running."
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else
    CONTAINER_ID="$(docker container ps --filter name=web --quiet)"
    log "Rebuilding Angular Frontend Inside of Container id:$CONTAINER_ID"
    docker exec $CONTAINER_ID bash -c "cd ../frontend; ng build --prod --output-hashing none"
fi