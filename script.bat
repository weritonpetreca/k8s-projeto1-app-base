@echo off
setlocal

rem --- Variaveis ---
rem IMPORTANTE: Altere "weritonpetreca" para o seu nome de usuario no Docker Hub
set DOCKER_USER=weritonpetreca
set VERSION=1.0

echo.
echo => Construindo as imagens Docker...
docker build -t %DOCKER_USER%/projeto-backend:%VERSION% backend/. || exit /b
docker build -t %DOCKER_USER%/projeto-database:%VERSION% database/. || exit /b
echo => Imagens construidas com sucesso!
echo.

rem --- Push para o Docker Hub ---
echo => Enviando as imagens para o Docker Hub...
docker push %DOCKER_USER%/projeto-backend:%VERSION% || exit /b
docker push %DOCKER_USER%/projeto-database:%VERSION% || exit /b
echo => Push realizado com sucesso!
echo.

rem --- Aplicacao dos Manifestos Kubernetes ---
echo => Aplicando os manifestos no cluster Kubernetes...

echo --> Criando os Services...
kubectl apply -f ./services.yml || exit /b

echo --> Criando os Deployments e o PVC...
kubectl apply -f ./deployment.yml || exit /b

echo.
echo => Aplicacao implantada com sucesso!
echo.
echo Para verificar o status, execute: kubectl get all
echo Para obter o IP de acesso, execute: kubectl get services php

endlocal