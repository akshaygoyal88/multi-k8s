docker build -t akshay1818/multi-client:latest -t akshay1818/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akshay1818/multi-server:latest -t akshay1818/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akshay1818/multi-worker:latest -t akshay1818/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akshay1818/multi-client:latest
docker push akshay1818/multi-server:latest
docker push akshay1818/multi-worker:latest

docker push akshay1818/multi-client:$SHA
docker push akshay1818/multi-server:$SHA
docker push akshay1818/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akshay1818/multi-server:$SHA
kubectl set image deployments/client-deployment client=akshay1818/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akshay1818/multi-worker:$SHA