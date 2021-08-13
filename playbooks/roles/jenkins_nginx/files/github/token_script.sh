
#!/bin/bash

# Script for creating jenkins user's api token and \
# creating a GitHub repo webhook with this token
# Created by Vitalii Klymov | user in GitHub: asxan
# 12 August 2021 year.

crumb=$(curl -s --cookie-jar /tmp/cookies -u "${JENKINS_ADMIN_ID}:${JENKINS_ADMIN_PASSWORD}" \
http://localhost:8080/crumbIssuer/api/json | \
awk  -F ":" '{print $3}' | awk -F "," '{print $1}' | sed 's/^"//;s/"$//')

token_json=$(curl -X POST -H "Jenkins-Crumb:$crumb" -s  \
--cookie /tmp/cookies  http://localhost:8080/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken?newTokenName=\admin_token \
-u "${JENKINS_ADMIN_ID}:${JENKINS_ADMIN_PASSWORD}")

api_token=$(echo "$token_json" | jq '.data.tokenValue' | sed 's/"//g')

curl -X POST -v -u "${GITHUB_USER}:${GITHUB_API_TOKEN}" -H "Accept:application/vnd.github.v3+json" \
https://api.github.com/repos/asxan/spring-petclinic/hooks \
--data @/var/jenkins_home/github_tokens/github.json
