#!/bin/bash

# Script for creating jenkins user's api token and \
# creating a GitHub repo webhook with this token
# Created by Vitalii Klymov | user in GitHub: asxan
# 12 August 2021 year.


crumb_json=$(curl -s --cookie-jar /tmp/cookies -u "${JENKINS_ADMIN_ID}:${JENKINS_ADMIN_PASSWORD}" \
http://localhost:8080/crumbIssuer/api/json)


echo "----------------------Crumb-------------------"
echo "$crumb_json"
echo ""

crumb=$(echo "$crumb_json" | jq '.crumb' | sed 's/^"//;s/"$//')

echo "----------------------Crumb-------------------"
echo "$crumb"
echo ""

token_json=$(curl -X POST -H "Jenkins-Crumb:$crumb" -s  \
--cookie /tmp/cookies  http://localhost:8080/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken?newTokenName=\admin_token \
-u "${JENKINS_ADMIN_ID}:${JENKINS_ADMIN_PASSWORD}")

# 
#------------------------token json----------------------
echo "$token_json"
#-------------------------------------------------------
echo ""

api_token=$(echo "$token_json" | jq '.data.tokenValue' | sed 's/"//g')

echo "--------------------API - Token----------------"
echo "$api_token"
echo ""

curl -X POST -v -u "${GITHUB_USER}:${GITHUB_API_TOKEN}" -H "Accept:application/vnd.github.v3+json" \
https://api.github.com/repos/asxan/spring-petclinic/hooks \
--data @/var/jenkins_home/github_tokens/github.json