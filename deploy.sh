docker build -t abhipatel7/multi-docker-client:latest -t abhipatel7/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhipatel7/multi-docker-server:latest -t abhipatel7/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhipatel7/multi-docker-worker:latest -t abhipatel7/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abhipatel7/multi-docker-client:latest
docker push abhipatel7/multi-docker-server:latest
docker push abhipatel7/multi-docker-worker:latest

docker push abhipatel7/multi-docker-client:$SHA
docker push abhipatel7/multi-docker-server:$SHA
docker push abhipatel7/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abhipatel7/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=abhipatel7/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=abhipatel7/multi-docker-worker:$SHA