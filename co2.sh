#!/bin/bash

cd ~/scripts/
sudo python -m mh_z19 --all > co2.json

co2=$(jq -r '.co2' ~/scripts/co2.json)
temperature=$(jq -r '.temperature' ~/scripts/co2.json)

DB_USER='root';
DB_PASSWD='root';
DB_NAME='grafana';
DB_TABLE='wetter';

if [ $co2 != "" ]
then

mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("co2", "$co2", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("temperature", "$temperature", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
EOF

fi