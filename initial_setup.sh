#  PROCEED WITH CAUTION - as this will delete the db folder 
#  This script will provide the initial database config
#  needed to start kamailio

# Shutdown docker-compose  
echo "*Shutdown the docker compose environment*"
docker compose down
#
echo "*Deleting the DB volume*"
sudo rm -rf db
mkdir db

# Run the Docker container
echo "*Starting Docker the inital DB will be created, yet blank* "
docker compose up -d

echo "*sleep for 10 seconds. Allow everything to boot*"
sleep 10

# Run kamdbctl create inside the Docker container
echo "*RECREATE AND REINIT THE KAMAILIO DB*" 
docker exec kamailio sh -c  "yes y | kamdbctl reinit kamailio"

docker restart kamailio