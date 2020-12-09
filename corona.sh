#!/bin/bash

# geometry durch eigene koordianten ersetzen
curl --request GET --url 'https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=GEN,cases7_per_100k&geometry=12.1893693%2C50.0577948&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json' > ~/scripts/corona.json
inzidenz=$(jq -r '.features[0].attributes.cases7_per_100k' ~/scripts/corona.json)

DB_USER='root';
DB_PASSWD='root';
DB_NAME='grafana';
DB_TABLE='corona';

mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
INSERT INTO $DB_TABLE (type, value, timestamp, date) VALUES ("inzidenz", "$inzidenz", "$(date +'%Y-%m-%d %H:%M:%S')", "$(date +'%Y-%m-%d %H:%M:%S')");
EOF

