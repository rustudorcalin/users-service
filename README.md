# Users API using Golang
We have a generic API service storing users, built up on Golang and using MariaDB as data storage. “main.go” describes all the needed variables to make it interacting with its db and how its exposed.

# API functionality

Description: Retrieves or adds users into the database

curl --header "Content-Type: application/json" --request POST --data '{"name":"test user","age":30}' http://host:8080/user
curl --header "Content-Type: application/json" --request POST --data '{"name":"test user 2","age":40}' http://host:8080/user
curl --header "Content-Type: application/json" http://host:8080/users
curl --header "Content-Type: application/json" http://host:8080/user/1
curl --header "Content-Type: application/json" http://host:8080/user/2

### Prerequisites
On the VM were you want to run this, you need to have the followings:
1. Google Cloud SDK 
- demo uses `google-cloud-sdk-225.0.0-1.el7.noarch`
2. Make sure that gcloud has access to the Cloud Platform with Google user credentials 
- `gcloud init` && `gcloud auth login`
3. kubectl is installed
- demo uses `kubectl-1.12.2-0.x86_64`
4. Docker is installed, running and logged to the docker registry
- demo uses `docker-1.13.1-75.git8633870.el7.centos.x86_64`
- `docker login`
5. Terraform 
- demo uses [0.11.10](https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip) version

### Building/testing steps

Download all the files from this repo. You will need to replace the dummy `account.json` file inside _secrets_ folder with your real one containing the service account information. Also, in _gke_ folder you will need to adjust the dummy project with your real one. Files needed to be edited with actual information:
- connections.tf:    project     = "dummy-charged-state"
- terraform.tfvars:project = "dummy-charged-state"
- variables.tf:  default = "dummy-charged-state"
1. Let's deploy the GKE cluster.

```bash
$ ll
total 7
drwxr-xr-x   8 crus  staff   256 Nov 16 00:12 .
drwx------+ 21 crus  staff   672 Nov 16 00:02 ..
-rwxr-xr-x   1 crus  staff  1442 Nov 15 21:15 deploy.sh
drwxr-xr-x   6 crus  staff   192 Nov 16 00:11 dockerfiles
drwxr-xr-x   6 crus  staff   192 Nov 16 00:10 gke
drwxr-xr-x   5 crus  staff   160 Nov 16 00:05 k8s
drwxr-xr-x   3 crus  staff    96 Nov 16 00:03 secrets

$ cd gke/
$ ll
total 32
drwxr-xr-x  6 crus  staff  192 Nov 16 00:10 .
drwxr-xr-x  8 crus  staff  256 Nov 16 00:12 ..
-rw-r--r--  1 crus  staff  150 Nov 16 00:05 connections.tf
-rw-r--r--  1 crus  staff  830 Nov 16 00:08 kubernetes.tf
-rw-r--r--  1 crus  staff  245 Nov 16 00:07 terraform.tfvars
-rw-r--r--  1 crus  staff  905 Nov 16 00:07 variables.tf

$ ../terraform init

$ ../terraform apply
google_container_cluster.k8s: Refreshing state... (ID: test-project)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_container_cluster.k8s
      id:                                    <computed>
      additional_zones.#:                    "2"
      additional_zones.2344402622:           "europe-west1-c"
      additional_zones.3304925305:           "europe-west1-d"
      addons_config.#:                       <computed>
      cluster_ipv4_cidr:                     <computed>
      enable_binary_authorization:           "false"
      enable_kubernetes_alpha:               "false"
      enable_legacy_abac:                    "false"
      enable_tpu:                            "false"
      endpoint:                              <computed>
      initial_node_count:                    "1"
      instance_group_urls.#:                 <computed>
      logging_service:                       <computed>
      master_auth.#:                         <computed>
      master_version:                        <computed>
      monitoring_service:                    <computed>
      name:                                  "test-project"
      network:                               "default"
      network_policy.#:                      <computed>
      node_config.#:                         "1"
      node_config.0.disk_size_gb:            "20"
      node_config.0.disk_type:               <computed>
      node_config.0.guest_accelerator.#:     <computed>
      node_config.0.image_type:              <computed>
      node_config.0.local_ssd_count:         <computed>
      node_config.0.machine_type:            "n1-standard-1"
      node_config.0.oauth_scopes.#:          "4"
      node_config.0.oauth_scopes.1277378754: "https://www.googleapis.com/auth/monitoring"
      node_config.0.oauth_scopes.1632638332: "https://www.googleapis.com/auth/devstorage.read_only"
      node_config.0.oauth_scopes.172152165:  "https://www.googleapis.com/auth/logging.write"
      node_config.0.oauth_scopes.299962681:  "https://www.googleapis.com/auth/compute"
      node_config.0.preemptible:             "true"
      node_config.0.service_account:         <computed>
      node_pool.#:                           <computed>
      node_version:                          <computed>
      private_cluster:                       "false"
      project:                               <computed>
      region:                                <computed>
      zone:                                  "europe-west1-b"


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_container_cluster.k8s: Creating...
  additional_zones.#:                    "" => "2"
  additional_zones.2344402622:           "" => "europe-west1-c"
  additional_zones.3304925305:           "" => "europe-west1-d"
  addons_config.#:                       "" => "<computed>"
  cluster_ipv4_cidr:                     "" => "<computed>"
  enable_binary_authorization:           "" => "false"
  enable_kubernetes_alpha:               "" => "false"
  enable_legacy_abac:                    "" => "false"
  enable_tpu:                            "" => "false"
  endpoint:                              "" => "<computed>"
  initial_node_count:                    "" => "1"
  instance_group_urls.#:                 "" => "<computed>"
  logging_service:                       "" => "<computed>"
  master_auth.#:                         "" => "<computed>"
  master_version:                        "" => "<computed>"
  monitoring_service:                    "" => "<computed>"
  name:                                  "" => "test-project"
  network:                               "" => "default"
  network_policy.#:                      "" => "<computed>"
  node_config.#:                         "" => "1"
  node_config.0.disk_size_gb:            "" => "20"
  node_config.0.disk_type:               "" => "<computed>"
  node_config.0.guest_accelerator.#:     "" => "<computed>"
  node_config.0.image_type:              "" => "<computed>"
  node_config.0.local_ssd_count:         "" => "<computed>"
  node_config.0.machine_type:            "" => "n1-standard-1"
  node_config.0.oauth_scopes.#:          "" => "4"
  node_config.0.oauth_scopes.1277378754: "" => "https://www.googleapis.com/auth/monitoring"
  node_config.0.oauth_scopes.1632638332: "" => "https://www.googleapis.com/auth/devstorage.read_only"
  node_config.0.oauth_scopes.172152165:  "" => "https://www.googleapis.com/auth/logging.write"
  node_config.0.oauth_scopes.299962681:  "" => "https://www.googleapis.com/auth/compute"
  node_config.0.preemptible:             "" => "true"
  node_config.0.service_account:         "" => "<computed>"
  node_pool.#:                           "" => "<computed>"
  node_version:                          "" => "<computed>"
  private_cluster:                       "" => "false"
  project:                               "" => "<computed>"
  region:                                "" => "<computed>"
  zone:                                  "" => "europe-west1-b"
google_container_cluster.k8s: Still creating... (10s elapsed)
google_container_cluster.k8s: Still creating... (20s elapsed)
google_container_cluster.k8s: Still creating... (30s elapsed)
google_container_cluster.k8s: Still creating... (40s elapsed)
google_container_cluster.k8s: Still creating... (50s elapsed)
google_container_cluster.k8s: Still creating... (1m0s elapsed)
google_container_cluster.k8s: Still creating... (1m10s elapsed)
google_container_cluster.k8s: Still creating... (1m20s elapsed)
google_container_cluster.k8s: Still creating... (1m30s elapsed)
google_container_cluster.k8s: Still creating... (1m40s elapsed)
google_container_cluster.k8s: Still creating... (1m50s elapsed)
google_container_cluster.k8s: Still creating... (2m0s elapsed)
google_container_cluster.k8s: Still creating... (2m10s elapsed)
google_container_cluster.k8s: Still creating... (2m20s elapsed)
google_container_cluster.k8s: Still creating... (2m30s elapsed)
google_container_cluster.k8s: Provisioning with 'local-exec'...
google_container_cluster.k8s (local-exec): Executing: ["/bin/sh" "-c" "gcloud container clusters get-credentials test-project --zone europe-west1-b --project=charged-state-215207"]
google_container_cluster.k8s (local-exec): Fetching cluster endpoint and auth data.
google_container_cluster.k8s (local-exec): kubeconfig entry generated for test-project.
google_container_cluster.k8s: Creation complete after 2m37s (ID: test-project)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

As you can see in the above output, it will take up to 3minutes for this to be ready. When finished, we can run some `kubectl` commands to check that nodes were created in the three zones we defined in terraform config file.

```bash
$ kubectl get nodes
NAME                                          STATUS   ROLES    AGE   VERSION
gke-test-project-default-pool-1d3ba1c1-wlbx   Ready    <none>   52s   v1.9.7-gke.11
gke-test-project-default-pool-9817ea37-1bz0   Ready    <none>   52s   v1.9.7-gke.11
gke-test-project-default-pool-dbd613fd-9d7p   Ready    <none>   52s   v1.9.7-gke.11

$ kubectl describe nodes gke-test-project-default-pool-1d3ba1c1-wlbx | grep zone
                    failure-domain.beta.kubernetes.io/zone=europe-west1-c

$ kubectl describe nodes gke-test-project-default-pool-9817ea37-1bz0 | grep zone
                    failure-domain.beta.kubernetes.io/zone=europe-west1-b

$ kubectl describe nodes gke-test-project-default-pool-dbd613fd-9d7p | grep zone
                    failure-domain.beta.kubernetes.io/zone=europe-west1-d
```

2. Let's deploy now the actual code on top of Kubernetes
There are two options here, either run the default containers, having version 1.0, which are already pushed to docker hub registry, either you can just build your own.

2.1 Deploying version 1:0

```bash
$ ./deploy.sh k8s/golang-mysql.yaml
====================================
Deploy using following images (y/n)?
====================================
calinrus/golang-api:1.0
calinrus/mariadb:1.0
y
Please wait for deployment. In progress...
configmap/golang-api-configs created
secret/password created
deployment.apps/myapp-deployment created
deployment.apps/mariadb-deployment created
service/myapp-lb created
service/mariadb-lb created
```

Let's check the status.

```bash
$ kubectl get deployments
NAME                 DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
mariadb-deployment   1         1         1            1           43s
myapp-deployment     1         1         1            1           43s
```

```bash
$ kubectl get pods
NAME                                  READY   STATUS    RESTARTS   AGE
mariadb-deployment-846dd7c7b5-rxwdl   1/1     Running   0          46s
myapp-deployment-6578c95d58-tfs9g     1/1     Running   0          46s
```

```bash
$ kubectl get svc
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)          AGE
kubernetes   ClusterIP      10.15.240.1    <none>          443/TCP          3m21s
mariadb-lb   ClusterIP      10.15.251.23   <none>          3306/TCP         66s
myapp-lb     LoadBalancer   10.15.243.56   35.240.37.115   8080:31566/TCP   66s
```
As we have a public IP, we can start testing our API service.

```bash
$ curl --header "Content-Type: application/json" --request POST --data '{"name":"test user","age":30}' http://35.240.37.115:8080/user
{"id":1,"name":"test user","age":30}

$ curl --header "Content-Type: application/json" --request POST --data '{"name":"test user 2","age":40}' http://35.240.37.115:8080/user
{"id":2,"name":"test user 2","age":40}

$ curl --header "Content-Type: application/json" http://35.240.37.115:8080/users
[{"id":1,"name":"test user","age":30},{"id":2,"name":"test user 2","age":40}]
 
$ curl --header "Content-Type: application/json" http://35.240.37.115:8080/user/1
{"id":1,"name":"test user","age":30}[root@demo-tlnv demo-project]# 

$ curl --header "Content-Type: application/json" http://35.240.37.115:8080/user/2
{"id":2,"name":"test user 2","age":40}[root@demo-tlnv demo-project]# 
```

2.2 Deploying version 2:0 (or else)
We will be removing only the deployments and leave the current services running. Of course you won't do this in a production environment, as you don't want to have a service disruption. To update a service without an outage, kubectl supports what is called `rolling update` which updates one pod at a time, rather than taking down the entire service at the same time. 

```bash
$ kubectl get deployments
NAME                 DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
mariadb-deployment   1         1         1            1           5m46s
myapp-deployment     1         1         1            1           5m46s

$ kubectl delete deployment myapp-deployment 
deployment.extensions "myapp-deployment" deleted

$ kubectl delete deployment mariadb-deployment 
deployment.extensions "mariadb-deployment" deleted
```

Let's run now again the deploy script and let it build new imagins for us, push them to registry and then create the deployments.

```bash
$ ./deploy.sh k8s/golang-mysql.yaml 
====================================
Deploy using following images (y/n)?
====================================
calinrus/golang-api:1.0
calinrus/mariadb:1.0
n
Version of the new <calinrus/golang-api> image to build and use(eg: 1.0):
2.0
Version of the new <calinrus/mariadb> image to build and use(eg: 1.0):
2.0
Sending build context to Docker daemon 130.9 MB
Step 1/9 : FROM golang:1.11.2-alpine
Trying to pull repository docker.io/library/golang ... 
1.11.2-alpine: Pulling from docker.io/library/golang
4fe2ade4980c: Pull complete 
2e793f0ebe8a: Pull complete 
77995fba1918: Pull complete 
cacfaec3bb6b: Pull complete 
885a921d7cd2: Pull complete 
Digest: sha256:e7462ca504afc789d289f2bb5fd471815cc11833439d2fe4e61915b190045359
Status: Downloaded newer image for docker.io/golang:1.11.2-alpine
 ---> 57915f96905a
Step 2/9 : RUN apk update &&     apk add git
 ---> Running in ee7dd717f55c

fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
v3.8.1-62-ga10c10dd7d [http://dl-cdn.alpinelinux.org/alpine/v3.8/main]
v3.8.1-61-g338ad9f579 [http://dl-cdn.alpinelinux.org/alpine/v3.8/community]
OK: 9546 distinct packages available
(1/6) Installing nghttp2-libs (1.32.0-r0)
(2/6) Installing libssh2 (1.8.0-r3)
(3/6) Installing libcurl (7.61.1-r1)
(4/6) Installing expat (2.2.5-r0)
(5/6) Installing pcre2 (10.31-r0)
(6/6) Installing git (2.18.1-r0)
Executing busybox-1.28.4-r1.trigger
OK: 19 MiB in 20 packages
 ---> 76495aed5a86
Removing intermediate container ee7dd717f55c
Step 3/9 : RUN go get github.com/go-sql-driver/mysql
 ---> Running in 461f86c2fc05

 ---> 10c3235f9031
Removing intermediate container 461f86c2fc05
Step 4/9 : RUN go get github.com/gorilla/mux
 ---> Running in b45a5a48879d

 ---> 0d04ae59b190
Removing intermediate container b45a5a48879d
Step 5/9 : WORKDIR /usr/src/app
 ---> eda3b398b972
Removing intermediate container 59567cafed2d
Step 6/9 : COPY dockerfiles/golang .
 ---> 364239e0aa7e
Removing intermediate container 22b3d9a26540
Step 7/9 : RUN go build -o /usr/local/bin/run_go
 ---> Running in 7dc4eed31873

 ---> b46314c77364
Removing intermediate container 7dc4eed31873
Step 8/9 : RUN rm -rf /usr/src/app
 ---> Running in 1a56fa69c54a

 ---> caecb145a510
Removing intermediate container 1a56fa69c54a
Step 9/9 : CMD /usr/local/bin/run_go
 ---> Running in 8a926ef325f0
 ---> 8f2102294344
Removing intermediate container 8a926ef325f0
Successfully built 8f2102294344
The push refers to a repository [docker.io/calinrus/golang-api]
f5027e4d150d: Pushed 
60335bb2884f: Pushed 
763fa37971dc: Pushed 
0a41c8d16206: Pushed 
0de74c29031e: Pushed 
81f1a0c000ee: Pushed 
7751f795b52f: Pushed 
f39b0ef275f5: Pushed 
93391cb9fd4b: Layer already exists 
cb9d0f9550f6: Layer already exists 
93448d8c2605: Layer already exists 
c54f8a17910a: Layer already exists 
df64d3292fd6: Layer already exists 
2.0: digest: sha256:790ba50a896a63441b14b21298bb6a9df40588b4c7da4eff063698c64d824f46 size: 3037
Sending build context to Docker daemon 130.9 MB
Step 1/5 : FROM mariadb:latest
Trying to pull repository docker.io/library/mariadb ... 
latest: Pulling from docker.io/library/mariadb
473ede7ed136: Pull complete 
c46b5fa4d940: Pull complete 
93ae3df89c92: Pull complete 
6b1eed27cade: Pull complete 
a7571426e9fe: Pull complete 
dba27abd0643: Pull complete 
3bfc1e8ac8a0: Pull complete 
01fbcb1aaebf: Pull complete 
0c112e7b58a2: Pull complete 
7a0418b24342: Pull complete 
dea457cf24a8: Pull complete 
21a8ebff5731: Pull complete 
8171c3b81842: Pull complete 
92c72b0d0b51: Pull complete 
Digest: sha256:9d443337dfbb2a34583ed7c968cde6115ce1b10630530ff1f0f5c7f1e6f0a76b
Status: Downloaded newer image for docker.io/mariadb:latest
 ---> 67238b4c1da0
Step 2/5 : ENV MYSQL_DATA_DIR /var/lib/mysql MYSQL_RUN_DIR /run/mysqld MYSQL_LOG_DIR /var/log/mysql
 ---> Running in 61c4b692d679
 ---> c366fee3ee54
Removing intermediate container 61c4b692d679
Step 3/5 : COPY dockerfiles/users.sql /docker-entrypoint-initdb.d/
 ---> f0c7664c5e06
Removing intermediate container 5bfd254277a0
Step 4/5 : RUN /usr/local/bin/docker-entrypoint.sh
 ---> Running in dfa5bbebc280

 ---> 2defb851e05e
Removing intermediate container dfa5bbebc280
Step 5/5 : EXPOSE 3306
 ---> Running in dfad99ba4cc8
 ---> 093255ab1f37
Removing intermediate container dfad99ba4cc8
Successfully built 093255ab1f37
The push refers to a repository [docker.io/calinrus/mariadb]
9188c43c7194: Pushed 
b39e2e96f104: Pushed 
668d0a8569bc: Layer already exists 
3cb29fa57336: Layer already exists 
c1daf1b67d29: Layer already exists 
d52fa3cdb5f8: Layer already exists 
fe39bb3a7dab: Layer already exists 
4d1ede312442: Layer already exists 
7e5bd674e3e4: Layer already exists 
240445b296c4: Layer already exists 
b8ea861a6a5d: Layer already exists 
625d6fc4a607: Layer already exists 
76c033092e10: Layer already exists 
2146d867acf3: Layer already exists 
ae1f631f14b7: Layer already exists 
102645f1cf72: Layer already exists 
2.0: digest: sha256:c22367ea94dc636347aed50aa58ec10a04af36728fb0db4ba469cf83fc574ed6 size: 3655
configmap/golang-api-configs unchanged
secret/password unchanged
deployment.apps/myapp-deployment created
deployment.apps/mariadb-deployment created
service/myapp-lb unchanged
service/mariadb-lb unchanged
```

We can check that the new pods deployed indeed have pulled this new image.

```bash
$ kubectl describe pods myapp-deployment-7bd79dfdb5-cvmp6 | grep image
  Normal  Pulling                39s   kubelet, gke-test-project-default-pool-1d3ba1c1-wlbx  pulling image "calinrus/golang-api:2.0"
  Normal  Pulled                 25s   kubelet, gke-test-project-default-pool-1d3ba1c1-wlbx  Successfully pulled image "calinrus/golang-api:2.0"
```

### Short recap
- deployed kubernetes cluster using terraform (`terraform apply` used to apply the changes required to reach the desired state of configuration).
- run a script in a "default mode" which created two deployments, one for the golang app, one for the database
- same script also allows you to build new containers from scratch and then create the deployments using them.
