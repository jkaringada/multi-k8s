docker build -t jbkar1/multi-client:latest -t jbkar1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jbkar1/multi-server:latest -t jbkar1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jbkar1/multi-worker:latest -t jbkar1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jbkar1/multi-client:latest
docker push jbkar1/multi-server:latest
docker push jbkar1/multi-worker:latest

docker push jbkar1/multi-client:$SHA
docker push jbkar1/multi-server:$SHA
docker push jbkar1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbkar1/multi-server:$SHA
kubectl set image deployments/client-deployment client=jbkar1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jbkar1/multi-worker:$SHA