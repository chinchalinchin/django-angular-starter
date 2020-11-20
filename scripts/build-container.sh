SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container'
nl=$'\n'
SCRIPT_DES="This script will stop and remove any Docker containers currently running ${nl}\
   on your machine, build a fresh application image and delete any dangling ${nl}\
   images leftover after the build completes. Running this script will remove  ${nl}\
   the database container and you will lose any data stored within it unless  ${nl}\
   you have manually backed it up. Run this script with care."
source "$SCRIPT_DIR/util/logging.sh"

if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
else

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

    log 'Application Image Built. Run \e[3mdocker-compose\e[0m To Start Application Server Container' $SCRIPT_NAME
fi