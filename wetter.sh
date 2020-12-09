#!/bin/bash

# YOUR_APP_ID bei openweathermap.org erstellen
curl --request GET --url 'http://api.openweathermap.org/data/2.5/weather?q=Nuremberg&appid=YOUR_APP_ID&units=metric' > ~/scripts/wetter.json
weather=$(jq -r '.weather[0].main' ~/scripts/wetter.json)
temperature=$(jq -r '.main.temp' ~/scripts/wetter.json)
humidity=$(jq -r '.main.humidity' ~/scripts/wetter.json)

DB_USER='root';
DB_PASSWD='root';
DB_NAME='grafana';
DB_TABLE='wetter';

mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("temperature", "$temperature", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("humidity", "$humidity", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("weather", "$weather", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
EOF


