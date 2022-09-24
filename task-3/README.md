## How to Deploy
* nginx - As a deployment behind a service and expose publicly using ingress
>* Assume nginx ingress-controller is already deployed and host is `webapp.ruwanvm.com`
>* Refer `nginx-deployment.yml` and `nginx-service.yml` definitions
* webapp - As a deployment behind a service (Assume PHP application)
>* Refer `php-deployment.yml` and `php-service.yml` definitions
* pgsql - As a statefulset using persistence volume behind a service
>* Refer `persistent-volume.yml`, `pgsql-deployment.yml` and `pgsql-service.yml` definitions
----------------------------------
## Scale the nginx container
* Deploy Horizontal Pod Autoscaler for nginx deployment based on the demand (metric)
> Assume `targetCPUUtilizationPercentage` as the Metric. We can use complex metrics with Metrics Server deployment
----------------------------------
## Keep Pgsql DB credentials
* Pgsql credentials are stored in a Kubernetes secret
>* Refer `pgsql-secret.yml` definition for secret deployment
>* Secret values are exposed as Environment variables to `php` and `pgsql` deployments
>```
>          envFrom:
>           - secretRef:
>               name: pgsql-db-credentials
>```
----------------------------------
## Upgrade with zero downtime
* Create helm chart to package the Kubernetes configurations
* Deploy using CI/CD pipeline (With unit tests and e2e tests)
* Use `Rolling updates` to achieve zero downtime deployment
>```
>  strategy:
>    type: RollingUpdate
>    rollingUpdate:
>      maxSurge: 25%
>      maxUnavailable: 25%
>```
----------------------------------
