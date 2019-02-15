docker build -t mdjamaddar/multi-client:latest -t mdjamaddar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mdjamaddar/multi-server:latest -t mdjamaddar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mdjamaddar/multi-worker:latest -t mdjamaddar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mdjamaddar/multi-client:latest
docker push mdjamaddar/multi-server:latest
docker push mdjamaddar/multi-worker:latest

docker push mdjamaddar/multi-client:$SHA
docker push mdjamaddar/multi-server:$SHA
docker push mdjamaddar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mdjamaddar/multi-server:$SHA
kubectl set image deployments/client-deployment client=mdjamaddar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mdjamaddar/multi-worker:$SHA
