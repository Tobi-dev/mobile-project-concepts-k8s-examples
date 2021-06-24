### Requirements

- Virtualbox
- repository files
- Ubuntu 20.04 LTS Server iso

### Install the Master Server
first you need to copy the "install-master.sh" to your master node with
````
scp /local/path/to/install-master.sh username@ip:/path/to/save
````
after that you need to change the permission to this file to be executable
`````
chmod u+x /path/to/install-master.sh
`````
next run the script by 
`````
cd /path/to/install-master.sh && sudo ./install-master.sh
````
note the kubeadm join command in the output somewhere

### Install Nodes
repeat this step for every node you have

copy the install-node.sh to your server by

````
scp /local/path/to/install-node.sh username@ip:/path/to/save
````
after that you need to change the permission to this file to be executable
````
chmod u+x /path/to/install-node.sh
````
next run the script by 

````
cd /path/to/install-master.sh && sudo ./install-node.sh
````
now join your master node with the kubeadm join command which you noted, keep in mind you have to run it with sudo

if you lost your join command you can get it by executing this on the master node
````
kubeadm token create --print-join-command
````

### Check the master node
to show now all nodes execute on your master
````
kubectl get node
````
and you see you successfully added your node to the master server.

### Installing an Ingress Controller
````
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.47.0/deploy/static/provider/baremetal/deploy.yaml
````

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


