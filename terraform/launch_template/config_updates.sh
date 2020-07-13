!#/bin/bash

# install the latest awscli to make sure we can access SSM
pip install -U awscli

# the configs in the CTFd ami need to be updated, let's take care of that here.
# get the values from SSM
DB_PASS=$(aws ssm get-parameter \
    --with-decryption \
    --name "/database/password" | jq -r .Parameter.Value)
DB_URL=$(aws ssm get-parameter \
    --name "/database/url" | jq -r .Parameter.Value)
REDIS_URL=$(aws ssm get-parameter \
    --name "redis" | jq -r .Parameter.Value)
AWS_S3_BUCKET=$(aws ssm get-parameter \
    --name "upload_bucket_name" | jq -r .Parameter.Value)
CTFD_KEY=$(aws ssm get-parameter \
    --name "ctfd_key" | jq -r .Parameter.Value)

# update the secret key
echo $CTFD_KEY > /opt/CTFd-2.5.0/.ctfd_secret_key

# update the db config
echo "Environment=DATABASE_URL=mysql+pymysql://ctfd:$DB_PASS@$DB_URL/ctfd" >> /etc/systemd/system/ctfd.service

# update the redis config
echo "Environment=CACHE_TYPE=redis" >> /etc/systemd/system/ctfd.service
echo "Environment=REDIS_URL=redis://$REDIS_URL" >> /etc/systemd/system/ctfd.service

# update the s3 config
echo "Environment=UPLOAD_PROVIDER=s3" >> /etc/systemd/system/ctfd.service
echo "Environment=AWS_S3_BUCKET=$AWS_S3_BUCKET" >> /etc/systemd/system/ctfd.service

# restart the app
sudo systemctl restart ctfd.service
