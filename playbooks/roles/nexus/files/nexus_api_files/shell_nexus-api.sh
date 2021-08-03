#!/bin/bash
# User flag -v for viewing more information about processes


NEXUS_ADMIN_PASSWORD=$(cat /home/vklymov/nexus_nginx/nexus_home/admin.password)

# Update admin user
jsonFile="/home/vklymov/nexus_nginx/nexus_api_files/update_admi_info.json"

curl -u "admin:$NEXUS_ADMIN_PASSWORD" -X PUT --header "Content-Type: application/json; charset=UTF-8" \
'http://localhost:8081/service/rest/v1/security/users/admin' --data @$jsonFile

# Set new admin password

NEW_NEXUS_ADMIN_PASSWORD=$(cat /home/vklymov/nexus_nginx/nexus_api_files/new_nexus_admin_password.txt)

curl -u "admin:$NEXUS_ADMIN_PASSWORD" -X PUT --header 'Content-Type: text/plain' \
'http://localhost:8081/service/rest/v1/security/users/admin/change-password' \
--data "$NEW_NEXUS_ADMIN_PASSWORD"

rm -rf /home/vklymov/nexus_nginx/nexus_home/admin.password

# Add releases privileage

jsonFile="/home/vklymov/nexus_nginx/nexus_api_files/repository_view_privilege_releases.json"

curl -u "admin:$NEW_NEXUS_ADMIN_PASSWORD" -X POST --header "Content-Type: application/json; charset=UTF-8" \
'http://localhost:8081/service/rest/v1/security/privileges/repository-view' --data @$jsonFile


# Add snapshot privileage

jsonFile="/home/vklymov/nexus_nginx/nexus_api_files/repository_view_privilege_snapshot.json"

curl -u "admin:$NEW_NEXUS_ADMIN_PASSWORD" -X POST --header "Content-Type: application/json; charset=UTF-8" \
'http://localhost:8081/service/rest/v1/security/privileges/repository-view' --data @$jsonFile

# Create asxan role

jsonFile="/home/vklymov/nexus_nginx/nexus_api_files/nexus_role.json"

curl -u "admin:$NEW_NEXUS_ADMIN_PASSWORD" -X POST --header "Content-Type: application/json; charset=UTF-8" \
'http://localhost:8081/service/rest/v1/security/roles' --data @$jsonFile

# Create new user

jsonFile="/home/vklymov/nexus_nginx/nexus_api_files/asxan_nexus_user.json"

curl -u "admin:$NEW_NEXUS_ADMIN_PASSWORD" -X POST --header "Content-Type: application/json; charset=UTF-8" \
'http://localhost:8081/service/rest/v1/security/users' --data @$jsonFile
