docker build -t owenh/multi-client:$SHA -t owenh/multi-client:latest -f ./client/Dockerfile ./client
docker build -t owenh/multi-server:$SHA -t owenh/multi-server:latest -f ./server/Dockerfile ./server
docker build -t owenh/multi-worker:$SHA -t owenh/multi-worker:latest -f ./worker/Dockerfile ./worker

docker push owenh/multi-client:latest
docker push owenh/multi-server:latest
docker push owenh/multi-worker:latest
docker push owenh/multi-client:$SHA
docker push owenh/multi-server:$SHA
docker push owenh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=owenh/multi-client:$SHA
kubectl set image deployments/server-deployment server=owenh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=owenh/multi-worker:$SHA
