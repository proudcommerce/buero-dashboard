#!/bin/bash

cd ~/miflora/

./flora.py poll C4:7C:8D:6A:4F:79 > ../scripts/flora.json
Temperature=$(jq -r '.Temperature' ~/scripts/flora.json)
Moisture=$(jq -r '.Moisture' ~/scripts/flora.json)
Light=$(jq -r '.Light' ~/scripts/flora.json)
Conductivity=$(jq -r '.Conductivity' ~/scripts/flora.json)
Battery=$(jq -r '.Battery' ~/scripts/flora.json)

DB_USER='root';
DB_PASSWD='root';
DB_NAME='grafana';
DB_TABLE='flora';

if [ $Moisture -gt 0 ]
then

mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
INSERT INTO $DB_TABLE (name, temperature, moisture, light, conductivity, battery) VALUES ("benny", "$Temperature", "$Moisture", "$Light", "$Conductivity", "$Battery");
EOF

fi
