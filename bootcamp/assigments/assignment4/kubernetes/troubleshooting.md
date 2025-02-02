# Kubernetes Troubleshooting

1. **`kubectl get pods`**
   Check the pod status to identify any issues.

   ```bash
   kubectl get pods
   ```

   Example:
   ```
   NAME                                READY   STATUS             RESTARTS   AGE
   flask-app-deployment-6fc6b76c89-9fzng   0/1     CrashLoopBackOff   5          10m
   ```
   From this I can see the pods crashed multiple times and restarted 5 times. Clearly someting's wrong

2. **`kubectl logs`**
   View logs from the pod to get insights on why it’s crashing.

   ```bash
   kubectl logs flask-app-deployment-6fc6b76c89-9fzng
   ```


3. **`kubectl describe pod`**
   Get detailed information about the pod, including events, container status, and reasons for failure.

   ```bash
   kubectl describe pod flask-app-deployment-6fc6b76c89-9fzng
   ```

   Here I can see the  image was pulled successfully, the container was created and started before it crashed. 

    ```bash
    Events:
  Type     Reason     Age                 From               Message
  ----     ------     ----                ----               -------
  Normal   Scheduled  40m                 default-scheduler  Successfully assigned default/flask-app-deployment-6fc6b76c89-827gl to minikube
  Normal   Pulled     40m                 kubelet            Successfully pulled image "qclaire/flask-docker-app" in 720ms (1.438s including waiting). Image size: 474460005 bytes.
  Normal   Pulled     40m                 kubelet            Successfully pulled image "qclaire/flask-docker-app" in 717ms (900ms including waiting). Image size: 474460005 bytes.
  Normal   Pulled     39m                 kubelet            Successfully pulled image "qclaire/flask-docker-app" in 723ms (723ms including waiting). Image size: 474460005 bytes.
  Normal   Created    39m (x4 over 40m)   kubelet            Created container flask-app
  Normal   Started    39m (x4 over 40m)   kubelet            Started container flask-app
  Normal   Pulled     39m                 kubelet            Successfully pulled image "qclaire/flask-docker-app" in 713ms (713ms including waiting). Image size: 474460005 bytes.
  Normal   Pulling    38m (x5 over 40m)   kubelet            Pulling image "qclaire/flask-docker-app"
  Warning  BackOff    1s (x186 over 40m)  kubelet            Back-off restarting failed container flask-app in pod flask-app-deployment-6fc6b76c89-827gl_default(549170ac-a179-45db-87c7-ad759bff9d75)
  ```

4. **`kubectl exec -it -- /bin/bash`**
   Enter the container to inspect the state directly and troubleshoot interactively.

   ```bash
   kubectl exec -it flask-app-deployment-6fc6b76c89-9fzng -- /bin/bash
   ```

   This would allow me to inspect things like volumes where one is mounted and specific files that can provide me runtime information.