## Approach

1. Develop a Dockerfile to create Docker image (using php:cli base image)
2. Push the image in to container registry like Dockerhub (image : `php-cli:latest`)
3. Provision an EKS cluster
4. Run the kubernetes resource `cronjob` on EKS cluster using the Docker image
----------------------------------
## Dockerfile

* Refer the `Dockerfile` in here
> Assume local script is in `src/cli/cron.php`
----------------------------------
## How to Schedule

* Schedule the cronjob resource to run on every minute
> `schedule: "* * * * *"`
* Refer the `cron.yml` in here
> Assume that PHP web application is running and, we are using another pod from same PHP image to schedule the cron (Not schedule on running web application)
----------------------------------