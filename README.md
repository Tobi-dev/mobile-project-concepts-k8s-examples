### Requirements

- Virtualbox
- repository files
- Ubuntu 20.04 LTS Server iso

### Install the Kubernetes single node
first you need to copy the "install-master.sh" to your master node with
````
scp /local/path/to/install.sh username@ip:/path/to/save
````
after that you need to change the permission to this file to be executable
`````
chmod u+x /path/to/install.sh
`````
next run the script by 
````
cd /path/to/install-master.sh && sudo ./install.sh
````
note the kubeadm join command in the output somewhere


### Check if node is ready
to show now all nodes execute on your master
````
kubectl get node
````
and you see you successfully added your node to the master server.

### Creating a Pod and Service and expose it
for now, we only work on the master server.
So for a service with high avaivability we need to create a service with a replica set. But the containers should also be on different nodes in case one node is offline.

for a simple example we will create a nginx webserver, expose it to port 8080, setup a replicaset of 2 and also configure a pod anti afinity.

````
kubectl apply -f nginx-deployment.yml
````

when everything is done you can take a look of your just created service by entering

````
kubectl get pods
kubectl get services
````


