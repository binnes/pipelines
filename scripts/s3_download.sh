eval "export $(cat model/config.json | jq -r 'to_entries | map("\(.key)=\(.value)") | @sh')"
eval "export $(echo ${MODEL} | jq -r 'to_entries | map("\(.key)=\(.value)") | @sh')"

TOKEN=`curl -X "POST" "https://iam.cloud.ibm.com/oidc/token" \
     -H 'Accept: application/json' \
     -H 'Content-Type: application/x-www-form-urlencoded' \
     --data-urlencode "apikey=${APIKEY}" \
     --data-urlencode "response_type=cloud_iam" \
     --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey" \
     -s | jq -r '.access_token'`

curl https://${MODEL_STORE_ENDPOINT}/${MODEL_STORE_BUCKET}/${MODEL_STORE_KEY} -H "authorization: bearer $TOKEN" -o ${MODEL_NAME}