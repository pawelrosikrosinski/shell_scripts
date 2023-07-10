#!/bin/bash

token='------------'

directory='------------'

line=$(head -n 1 passwords.txt)

curl -X GET "https://api.vimeo.com/me/projects/{'$directory'}/videos?per_page=100&fields=uri"  -H 'Authorization: bearer  '$token |grep uri |grep -v  fields| cut  -c 21-37 | while read in; do ( curl -X PATCH https://api.vimeo.com$in -H 'Authorization: bearer '$token -d '{"privacy":{"view": "disable"}}'  -H 'Content-Type: application/json'  -H 'Accept: application/json'); done;

sleep 10;

curl -X GET "https://api.vimeo.com/me/projects/{'$directory'}/videos?per_page=100&fields=uri"  -H 'Authorization: bearer  '$token |grep uri |grep -v  fields| cut  -c 21-37 | while read in; do  curl -X PATCH https://api.vimeo.com$in -H 'Authorization: bearer  '$token -d '{"privacy":{"view": "password"}, "password":"'$line'"}'  -H 'Content-Type: application/json'  -H 'Accept: application/json'; done;

sed -i  '1d' passwords.txt

