#!/bin/bash

# Create the GCloud Authentication file if set
    touch /root/gcloud.json
    echo "$GCP_GCLOUD_AUTH" > /root/gcloud.json
    gcloud auth activate-service-account --key-file=/root/gcloud.json


#backup filestore to GCS

#set date in proper format
DATE=$(date +"%m-%d-%Y-%T")

#create folder in container to mount filestore share and mount filestore
mkdir -p /mnt/$FILESHARE_MOUNT_PRIMARY
mount $FILESTORE_IP_PRIMARY:/$FILESHARE_NAME_PRIMARY /mnt/$FILESHARE_MOUNT_PRIMARY

#backup filestore contents to google cloud storage bucket 
gsutil rsync -r /mnt/$FILESHARE_MOUNT_PRIMARY/ gs://$GCP_BUCKET_NAME/$DATE/


#rsync filestore to secondary region
mkdir -p /mnt/$FILESHARE_MOUNT_SECONDARY
mount $FILESTORE_IP_SECONDARY:/$FILESHARE_NAME_SECONDARY /mnt/$FILESHARE_MOUNT_SECONDARY
rsync -avz /mnt/$FILESHARE_MOUNT_PRIMARY/ /mnt/$FILESHARE_MOUNT_SECONDARY/


