docker build -t jbsolanki/multi-client-k8s:latest -t jbsolanki/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jbsolanki/multi-server-k8s:latest -t jbsolanki/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t jbsolanki/multi-worker-k8s:latest -t jbsolanki/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jbsolanki/multi-client-k8s:latest
docker push jbsolanki/multi-server-k8s:latest
docker push jbsolanki/multi-worker-k8s:latest

docker push jbsolanki/multi-client-k8s:$SHA
docker push jbsolanki/multi-server-k8s:$SHA
docker push jbsolanki/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbsolanki/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=jbsolanki/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jbsolanki/multi-worker-k8s:$SHA