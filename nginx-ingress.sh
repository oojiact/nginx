#!/bin/sh
curl -o get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get
chmod +x get_helm.sh
./get_helm.sh
helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account tiller --upgrade
helm init
kubectl get deployments -n kube-system
kubectl run hello-app --image=gcr.io/google-samples/hello-app:1.0 --port=8080
kubectl expose deployment hello-app
helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true
sleep 30
kubectl get service nginx-ingress-controller
cat <<EOF > ingress-resource.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-resource
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /hello
        backend:
          serviceName: hello-app
          servicePort: 8080
EOF
kubectl apply -f ingress-resource.yaml
kubectl get ingress ingress-resource
