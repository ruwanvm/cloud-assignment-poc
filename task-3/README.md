## How to Deploy
* nginx - as a deployment behind a service and expose to public using ingress
> nginx ingress-controller is already deployed
* webapp - as a deployment behind a service
> https://www.stackovercloud.com/2019/08/08/how-to-deploy-a-php-application-with-kubernetes-on-ubuntu-18-04/
* pgsql - as a statefulset using persistance storage behind a service
> https://www.eksworkshop.com/intermediate/200_migrate_to_eks/deploy-counter-db-in-eks/

----------------------------------
## Scale the nginx container
* Deploy Horizontal Pod Autoscaler for nginx deployment based on the demand (metric)
> Metrics Server is already deployed

> https://cloud.google.com/kubernetes-engine/docs/how-to/horizontal-pod-autoscaling#kubectl-apply
----------------------------------
## Keep Pgsql DB credentials
* Pgsql creadentials are stored in a Kubernetes secret
> https://medium.com/@xcoulon/managing-pod-configuration-using-configmaps-and-secrets-in-kubernetes-93a2de9449be
----------------------------------
## Upgrade with zero downtime
* Create helm chart to package the Kubernetes configurations
* Deploy using CI/CD pipeline (`GitHub actions` used here)
* Use `Rolling updates` to acheive zero downtime deployment
----------------------------------

https://www.stackovercloud.com/2019/08/08/how-to-deploy-a-php-application-with-kubernetes-on-ubuntu-18-04/

https://devopscube.com/deploy-postgresql-statefulset/

https://www.eksworkshop.com/intermediate/200_migrate_to_eks/deploy-counter-db-in-eks/

