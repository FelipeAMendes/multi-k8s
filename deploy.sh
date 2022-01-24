docker build -t felipeamendes/multi-client:latest -t felipeamendes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t felipeamendes/multi-server:latest -t felipeamendes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t felipeamendes/multi-worker:latest -t felipeamendes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push felipeamendes/multi-client:latest
docker push felipeamendes/multi-client:$SHA

docker push felipeamendes/multi-server:latest
docker push felipeamendes/multi-server:$SHA

docker push felipeamendes/multi-worker:latest
docker push felipeamendes/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=felipeamendes/multi-client:$SHA
kubectl set image deployments/server-deployment server=felipeamendes/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=felipeamendes/multi-worker:$SHA
