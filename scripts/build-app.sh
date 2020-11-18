SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-app.sh'
source "$SCRIPT_DIR/util/logging.sh"

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