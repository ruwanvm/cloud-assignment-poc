## Approach

1. Develop a Dockerfile to create Docker image (using php:cli base image)
2. Push the image in to container registry like Dockerhub (image : `php-cli:latest`)
2. Provision an EKS cluster
3. Run the kubernetes resource cronjob on EKS cluster using the Docker image
----------------------------------
## Dockerfile

* Refer the `Dockerfile` in here
----------------------------------
## How to Schedule

* Schedule the cronjob resource to run on every minute

* Refer the `cron.yml` in here


> Assume that PHP web application is running and, we are using another pod from same PHP image to schedule the cron (Not schedule on running web application)
----------------------------------