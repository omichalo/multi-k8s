docker build -t omichalo/multi-client:latest -t omichalo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omichalo/multi-server:latest -t omichalo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omichalo/multi-worker:latest -t omichalo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omichalo/multi-client:latest
docker push omichalo/multi-server:latest
docker push omichalo/multi-worker:latest

docker push omichalo/multi-client:$SHA
docker push omichalo/multi-server:$SHA
docker push omichalo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=omichalo/multi-client:$SHA
kubectl set image deployments/server-deployment server=omichalo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=omichalo/multi-worker:$SHA