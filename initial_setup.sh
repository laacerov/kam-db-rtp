#  PROCEED WITH CAUTION - as this will delete the db folder
#  This script will provide the initial database config
#  needed to start kamailio

# Shutdown docker-compose
echo "*Shutdown the docker compose environment*"
docker compose down
#
echo "*Deleting the DB volume*"
sudo rm -rf db
mkdir db/config -p

# Run the Docker container
echo "*Starting Docker the inital DB will be created, yet blank* "
docker compose up -d

echo "*sleep for 10 seconds. Allow everything to boot*"
sleep 10

# Run db_respaldo to contenedor db
echo "*Starting copy respaldodb to DB"
docker cp kamailio_structure.sql db:/usr/src/kamailio_structure.sql

# Exec script restore_db to contenedor DB
docker cp restore_db.sh db:/usr/local/bin/restore_db.sh
docker exec -it db chmod +x /usr/local/bin/restore_db.sh

sleep 5
echo "*Starting exec script restore_DB"
docker exec -it db bash /usr/local/bin/restore_db.sh

# Restart kamailio
docker restart kamailio

# Run kamdbctl create inside the Docker container
echo "*RECREATE AND REINIT THE KAMAILIO DB*"
docker exec kamailio sh -c  "yes y | kamdbctl reinit kamailio"