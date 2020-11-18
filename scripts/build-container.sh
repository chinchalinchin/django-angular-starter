SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container.sh'
source "$SCRIPT_DIR/util/logging.sh"

if [ ! -f "$SCRIPT_DIR/../env/container.env" ]
then
    log 'No Environment File Detected' $SCRIPT_NAME
    log 'Initializing New Environment File' $SCRIPT_NAME
    cp $SCRIPT_DIR/../env/.sample.env $SCRIPT_DIR/../env/container.env
    log "Please Configure \e[3m$SCRIPT_DIR/../env/container.env\e[0m And Then Reinvoke This Script" $SCRIPT_NAME
    exit 0
fi

log 'Removing Running Containers' $SCRIPT_NAME
docker-compose down

log 'Clearing Docker Cache' $SCRIPT_NAME
docker system prune -f

log 'Building Application Image' $SCRIPT_NAME
docker-compose build

log 'Deleting Dangling Images' $SCRIPT_NAME
docker rmi $(docker images --filter "dangling=true" -q)

log 'Orchestrating Images' $SCRIPT_NAME
docker-compose up