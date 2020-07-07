This project aims to create a container for taking regular backups of Google Filestore to Google Cloud Storage bucket. It also sync the filestore in primary region to another filestore in secondary region for disaster recovery at regular intervals. We can deploy this container as a kubernetes cronjob to a GKE cluster where Google Cloud Filestore is assosiated with. 

I'm able to successfully deploy the container as kuberenetes cronjob in GKE cluster but the container doesn't mount google filestore. It seems to be an issue with google filestore. 
