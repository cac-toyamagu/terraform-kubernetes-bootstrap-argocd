aws secretsmanager update-secret --secret-id ${SECRET_ID}\
    --secret-string "{\"client_id\":\"${CLIENT_ID}\",\"client_secret\":\"${CLIENT_SECRET}\"}"