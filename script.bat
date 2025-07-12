echo "Criando as imagens..."

docker build -t weritonpetreca/projeto-backend:1.0 backend/.
docker build -t weritonpetreca/projeto-database:1.0 database/.

echo "Imagens criadas com sucesso!"
echo "Realizando o push das imagens..."

docker push weritonpetreca/projeto-backend:1.0
docker push weritonpetreca/projeto-database:1.0

echo "Push realizado com sucesso!"
echo "Criando serviços no cluster Kubernetes..."

kubectl apply -f ./services.yaml

echo "Serviços criados com sucesso!"
echo "Criando os deployments no cluster Kubernetes..."

kubectl apply -f ./deployments.yaml