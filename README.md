# Projeto Aplicação Web com PHP, MySQL e Kubernetes

Este projeto demonstra a criação e orquestração de uma aplicação web simples, composta por um backend em PHP e um banco de dados MySQL, utilizando Docker para containerização e Kubernetes para orquestração. O objetivo é criar um sistema onde usuários podem enviar mensagens através de um formulário, e essas mensagens são persistidas no banco de dados.

## 📝 Arquitetura

A aplicação é dividida em três componentes principais, cada um rodando em seu próprio container dentro de um cluster Kubernetes:

1.  **Frontend**: Uma interface de usuário simples (HTML/CSS/JS) que permite ao usuário inserir dados em um formulário. O JavaScript (usando jQuery) é responsável por enviar os dados para o backend via uma requisição AJAX.
2.  **Backend (PHP)**: Um servidor PHP que recebe os dados do frontend. Ele se conecta ao serviço do MySQL para persistir as informações (nome, email e comentário) na tabela `mensagens`.
3.  **Database (MySQL)**: Uma instância do MySQL que armazena os dados da aplicação. Os dados são persistidos fora do pod usando um `PersistentVolumeClaim`, garantindo que não sejam perdidos se o pod for reiniciado.

Os componentes se comunicam dentro do cluster da seguinte forma:
*   O **Frontend** é acessado publicamente através de um Service do tipo `LoadBalancer` que expõe o **Backend PHP**.
*   O **Backend PHP** se conecta ao **Database MySQL** usando o nome do serviço `mysql-connection`, que o Kubernetes resolve para o IP do pod do banco de dados.



## 🚀 Tecnologias Utilizadas

*   **Backend**: PHP
*   **Banco de Dados**: MySQL
*   **Frontend**: HTML, CSS, JavaScript (jQuery)
*   **Containerização**: Docker
*   **Orquestração**: Kubernetes

## 📋 Pré-requisitos

Antes de começar, você precisará ter as seguintes ferramentas instaladas e configuradas:

*   **Docker**: Para construir as imagens da aplicação.
*   **kubectl**: A ferramenta de linha de comando para interagir com o cluster Kubernetes.
*   **Cluster Kubernetes**: Pode ser o Minikube, Docker Desktop, Kind, ou um cluster em um provedor de nuvem (GKE, EKS, AKS).
*   **Conta no Docker Hub**: Para enviar as imagens Docker construídas.

## ⚙️ Como Executar o Projeto

Siga os passos abaixo para implantar a aplicação no seu cluster.

### 1. Clone o Repositório

### 2. Atualize o Nome de Usuário do Docker

No arquivo `script.bat`, substitua `weritonpetreca` pelo seu nome de usuário do Docker Hub.
Você também precisará fazer a mesma alteração nos arquivos de `deployment.yml` para as imagens:

### 3. Construa e Envie as Imagens

Execute o script para construir as imagens Docker e enviá-las para o Docker Hub.

Dê permissão de execução: No seu terminal, execute o seguinte comando para tornar o script executável:

    chmod +x script.sh
    
Execute o script:

**No Windows:** ./script.bat

**No Linux/macOS:** ./script.sh
    
### 4. Implante no Kubernetes

O `script.bat` já executa os comandos `kubectl apply`. Se você não usou o script, aplique os manifestos manualmente:

### 5. Acesse a Aplicação

Para encontrar o endereço IP para acessar a aplicação, execute o comando:

Você verá uma saída parecida com esta:

Copie o `<IP_EXTERNO>` e cole no seu navegador.

### 6. Configure o Frontend

O arquivo `frontend/js.js` precisa saber o endereço do backend. Atualize a URL no `js.js` com o IP externo obtido no passo anterior.
> **Nota**: Em um cenário de produção, o ideal seria que o frontend fosse servido pelo próprio backend PHP, evitando a necessidade de configurar o IP manualmente.

## 💡 Pontos de Melhoria

Este é um projeto de estudo e existem várias oportunidades de melhoria para torná-lo mais robusto e seguro:

1.  **Segurança das Credenciais**: As credenciais do banco de dados (`conexao.php`) estão hard-coded. O ideal é usar **Kubernetes Secrets** para armazenar senhas e injetá-las como variáveis de ambiente nos containers.
2.  **Configuração de URL Dinâmica**: A URL do backend no `frontend/js.js` está incompleta. O ideal seria servir os arquivos do frontend a partir do próprio servidor PHP, para que as chamadas AJAX pudessem usar um caminho relativo (ex: `/conexao.php`).
