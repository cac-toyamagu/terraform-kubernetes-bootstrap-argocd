echo "${CLIENT_ID_NAME}"
echo "${CLIENT_SECRET_NAME}"

aws ssm put-parameter \
    --name ${CLIENT_ID_NAME} \
    --value ${CLIENT_ID} \
    --type "SecureString"\
    --overwrite

aws ssm put-parameter \
    --name ${CLIENT_SECRET_NAME} \
    --value ${CLIENT_SECRET} \
    --type "SecureString"\
    --overwrite
