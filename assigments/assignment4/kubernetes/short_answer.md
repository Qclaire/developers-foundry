# Short Answer Questions

1. **Describe the role of etcd in Kubernetes.**
   > etcd is a distributed key-value store that holds all of Kubernetes cluster data, like configuration, state, and metadata of resources. It acts as the source of truth for the cluster.

2. **What happens if a Pod in a Deployment crashes?**
   > The Deployment controller will automatically create a new Pod to replace it, to ensure the desired number of replicas is maintained.

3. **Explain the difference between a ConfigMap and a Secret in Kubernetes.**
   > A **ConfigMap** is used to store non-sensitive configuration data, like environment variables or configuration files.

   > A **Secret** is used to store sensitive data, such as passwords, API keys, or certificates, and is encoded for security.

4. **Why is Ingress preferred over exposing services directly with NodePort?**
   > **Ingress** provides a more flexible way to manage external access to services, allowing for features like SSL termination, routing based on URL paths, and load balancing 

   > **NodePort** exposes services on every node and is less secure and harder to manage.

5. **What does `kubectl get pods -o wide` display that `kubectl get pods` does not?**
   > The `-o wide` option displays additional information such as the node the Pod is running on, its IP address, and the container images being used, which are not shown in the default `kubectl get pods` output.
