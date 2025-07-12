#!/bin/bash

# Encerra o script se qualquer comando falhar
set -e

# --- Variáveis ---
# IMPORTANTE: Altere "weritonpetreca" para o seu nome de usuário no Docker Hub
DOCKER_USER="weritonpetreca"
VERSION="1.0"

# --- Build das Imagens Docker ---
echo "=> Construindo as imagens Docker..."
docker build -t ${DOCKER_USER}/projeto-backend:${VERSION} backend/.
docker build -t ${DOCKER_USER}/projeto-database:${VERSION} database/.
echo "=> Imagens construídas com sucesso!"
echo ""

# --- Push para o Docker Hub ---
echo "=> Enviando as imagens para o Docker Hub..."
docker push ${DOCKER_USER}/projeto-backend:${VERSION}
docker push ${DOCKER_USER}/projeto-database:${VERSION}
echo "=> Push realizado com sucesso!"
echo ""

# --- Aplicação dos Manifestos Kubernetes ---
echo "=> Aplicando os manifestos no cluster Kubernetes..."

echo "--> Criando os Services..."
kubectl apply -f ./services.yml

echo "--> Criando os Deployments e o PVC..."
kubectl apply -f ./deployment.yml

echo ""
echo "=> Aplicação implantada com sucesso!"
echo ""
echo "Para verificar o status, execute: kubectl get all"
echo "Para obter o IP de acesso, execute: kubectl get services php"
