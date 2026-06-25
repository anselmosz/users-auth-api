# User Authentication API

![GitHub last commit](https://img.shields.io/github/last-commit/anselmosz/users-auth-JWT-API)
![GitHub repo size](https://img.shields.io/github/repo-size/anselmosz/users-auth-JWT-API)
![GitHub issues](https://img.shields.io/github/issues/anselmosz/users-auth-JWT-API)
![GitHub stars](https://img.shields.io/github/stars/anselmosz/users-auth-JWT-API)

![Node.js](https://img.shields.io/badge/node-%3E%3D18-green)
![Express](https://img.shields.io/badge/express-4.x-blue)
![MySQL](https://img.shields.io/badge/mysql-8.x-orange)
![JWT](https://img.shields.io/badge/auth-JWT-black)

---

## 📚 Table of Contents

- [📌 Sobre o projeto](#-sobre-o-projeto)
- [🌐 Deploy](#-deploy)
- [🎯 Objetivo](#-objetivo-do-sistema)
- [🚀 Funcionalidades](#-funcionalidades-atuais)
- [🏛️ Arquitetura](#️-arquitetura-do-projeto)
- [🧱 Estrutura](#-estrutura-de-módulos)
- [⚙️ Tecnologias](#️-tecnologias-utilizadas)
- [🔌 Endpoints](#-endpoints-da-api)
- [Como rodar o projeto](#como-executar-o-projeto)
- [🐋 Como executar (com Docker)](#-como-executar-o-projeto-com-docker)
- [▶️ Como executar (com Node)](#️-como-executar-o-projeto-com-node)

---

## 📌 Sobre o projeto

API de autenticação e gerenciamento de usuários baseada em JWT, desenvolvida com foco em boas práticas de backend, arquitetura em camadas e isolamento de dados por conta.

O projeto simula um cenário real de sistema multi-tenant, permitindo que empresas criem contas e gerenciem seus usuários com controle de permissões (admin/member).

Além da implementação das regras de negócio, o projeto também explora:
- organização modular da aplicação
- autenticação stateless com JWT
- segurança com hash de senhas (bcrypt)
- fluxo de desenvolvimento baseado em Git Flow (branch development e main)
- deploy em ambiente de produção (Render + banco em cloud)

Criado como base reutilizável para futuros projetos que necessitem de autenticação e autorização.

---

## 🌐 Deploy

🔗 **API URL:** https://users-auth-jwt-api.onrender.com

🔗 **Documentação (Swagger):** [Link da docuemntação](https://users-auth-jwt-api.onrender.com/api-docs) 

---

## 🎯 Objetivo do Sistema

Permitir que empresas:

* Criem contas
* Administradores criem e gerenciem usuários

Permitir que usuários

* Façam login
* Faça, reset de senha
* Sejam identificados como administradores ou membros para limitar suas ações

---

## 🚀 Funcionalidades atuais

Atualmente o sistema possui os seguintes recursos implementados:

### Autenticação

* Registro de conta
* Criação automática de usuário administrador
* Login com geração de token JWT
* Criação de usuário com senha aleatória
* Redefinição de senha com base em dados de login

### Gestão de usuários

* Criar usuários
* Listar usuários
* Buscar usuário por ID
* Atualizar usuário
* Remover usuário
* Ativar ou desativar um usuário

### Segurança

* Autenticação via **JWT**
* Controle de permissões (admin / usuário)
* Isolamento de dados por **account_id**

---

## 🏛️ Arquitetura do projeto

O projeto segue uma arquitetura em camadas:

```
Controller
↓
Service
↓
Repository
↓
Database
```

### Responsabilidade de cada camada

**Controllers**

* recebem requisições HTTP
* validam dados da requisição
* retornam respostas

**Services**

* contêm a lógica de negócio
* coordenam operações entre repositories
* gerenciam transactions

**Repositories**

* responsáveis pelas queries no banco
* isolam acesso ao banco de dados

---

## 🧱 Estrutura de módulos

O sistema é organizado em módulos baseados no domínio da aplicação.

```
src
 ├ config
 ├ middlewares
 ├ modules
 │   ├ auth
 │   └ users
 │
 ├ services
 └ utils 
```

### auth

Responsável por:

* registro de contas
* autenticação
* geração de token JWT
* bloqueio de acesso

### users

Responsável por:

* CRUD de usuários
* gerenciamento de permissões
* associação de usuários a contas
* desativar ou ativar usuários

---

## ⚙️ Tecnologias utilizadas

#### Backend

* Node.js
* Express

#### Banco de dados

* MySQL

#### Query Builder

* Knex.js

#### Autenticação

* JSON Web Token (JWT)
* bcrypt

#### Outras dependências

* dotenv
* nodemon
* cors
* cross-env

---

## 🔌 Endpoints da API

### 🔒 Auth

Responsável por autenticação e criação de contas.

| Método | Endpoint       | Descrição                           |
| ------ | -------------- | ----------------------------------- |
| POST   | /auth/register | Criar conta e usuário administrador |
| POST   | /auth/login    | Login e geração de token JWT        |
| POST   | /auth/reset    | Reset de senha do usuário           |

#### Exemplo de body para criação de conta na rota /auth/register

```json
{
    "company": {
        "name": "Empresa exemplo",
        "plan": "pro"
    },
    "user": {
        "name": "Administrador",
        "email": "admin@empresa.com.br",
        "senha": "senha@1234"
    }
}
```

#### Exemplo de body para login

```json
{
    "email": "admin@empresa.com.br",
    "senha": "senha@1234"
}

```

#### Exemplo de body para reset

```json
{
    "email": "usuario@empresa.com.br",
    "senha": "senha@1234",
    "senhaNova": "1234@senha",
    "confirmarSenha": "12334@senha"
}

```

---

### 👤 Users

Endpoints para gerenciamento de usuários.

⚠ Todas as rotas requerem **token JWT no header Authorization**

```
Authorization: Bearer TOKEN
```

| Método | Endpoint             | Descrição                                 |
| ------ | -------------------- | ----------------------------------------- |
| POST   | /users               | Criar novo usuário com senha aleatória    |
| GET    | /users               | Listar usuários                           |
| GET    | /users/id            | Buscar usuário por ID                     |
| PUT    | /users/id            | Atualizar usuário                         |
| DELETE | /users/id            | Remover usuário                           |
| PATCH  | /users/id/activate   | Ativar usuário                            |
| PATCH  | /users/id/deactivate | Desativar usuário                         |

#### Exemplo de body para criação de usuário

```json
{
    "name" : "Usuário",
    "email": "user@empresa.com.br",
    "role": "member"
}
```

---

### Como executar o projeto

#### Formas de execução

O projeto pode ser executado de duas formas:

- 🐋 Docker: aplicação e banco de dados executados em containers.
- ▶️ Node.js: aplicação executada localmente utilizando um banco MySQL instalado na máquina.

Escolha apenas uma das opções

#### 📋 Pré-requisitos

Para executar o projeto localmente você precisará de uma das opções abaixo:

#### Opção 1 - Docker

- Docker Engine
- Docker Compose

#### Opção 2 - Node.js

- Node.js >= 18
- npm
- MySQL 8+

#### 1 Clonar o repositório e acessar o local

```bash
git clone https://github.com/anselmosz/users-auth-api

cd users-auth-api
```

#### 2 Configurar variáveis de ambiente

Antes de executar o projeto, configure o arquivo `.env.development`.

Esse arquivo é utilizado tanto pela aplicação Node.js quanto pelo Docker Compose para configurar o ambiente de desenvolvimento.

```
NODE_ENV=development

PORT=4000

DB_CLIENT=mysql2
DATABASE_URL=mysql-dev (para docker) ou localhost (para banco rodando na sua máquina)
DB_PORT=3306
DB_NAME=db_auth_jwt
DB_USER=username
DB_PASSWORD=password

JWT_SECRET=seu_secret
JWT_EXPIRES_IN=1h
```
#### Descrição das variáveis

| Variável         | Descrição                                |
| ---------------- | ---------------------------------------- |
| NODE_ENV         | Tipo de ambiente que estará sendo rodado |
| PORT             | Porta onde a aplicação estará rodando    |
| DB_CLIENT        | Cliente do banco                         |
| DATABASE_URL     | URL onde o banco está rodando            |
| DB_PORT          | Porta onde o banco de dados está rodando |
| DB_NAME          | Nome do banco de dados                   |
| DB_USER          | Usuário do banco de dados                |
| DB_PASSWORD      | Senha do usuário do banco                |
| JWT_SECRET       | Chave secreta do token JWT               |
| JWT_EXPIRES_IN   | Tempo de expiração do token              |


### 🐋 Como executar o projeto com Docker

Para essa execução, você precisa ter o Docker instalado em sua máquina: [link da documentação de instalação do Docker Engine no Ubuntu](https://docs.docker.com/engine/install/ubuntu/) (SO que estou usando atualmente)

#### Realizar a criação dos containers via docker compose

Acesse pasta do repositório em sua máquina e rode o seguinte comando:

```bash
docker compose --profile dev --env-file .env.development up -d
```

O profile `dev` inicia a aplicação utilizando a imagem de desenvolvimento definida no arquivo `docker-compose.yml`.

#### Validando a execução

Aguarde a finalização do build da imagem da aplicação, criação dos containers e inicialização do banco de dados. Após isso, rode o comando `docker ps` para verificar se os containers `users-api-dev` e `mysql-dev` foram criados corretamente e estão em execução.

Com a inicialização dos containers:
- **API:** http://localhost:4000
- **Banco de dados:** localhost:3306

Após os containers iniciarem, realize uma requisição para `POST /auth/register`

Se o registro for criado com sucesso, a API e o banco de dados estão funcionando corretamente.

#### Validação adicional

Caso se depare com algum erro utlize os comandos `docker compose logs -f` ou `docker logs users-api-dev -f` (para verificar especificamente o container da API) 

#### Parar os containers

```bash
docker compose --profile dev down
```

Ou: 
```bash
docker compose --profile dev down -v
```

### ▶️ Como executar o projeto com Node

#### Instalar dependências

```
npm install
```

#### Criar o banco de dados

Para este projeto, em testes locais usei o MySQL, utilizando o script `init.sql`

* Acessando o mysql via terminal, rode o seguinte comando:

```
source <path_to>/init.sql
```

#### Executar o projeto criando a instância de desenvolvimento

```
npm run dev
```

### Problemas comuns

#### Porta 3306 já está em uso por um container

Altere o mapeamento de portas no docker-compose.yml.

#### Erro de conexão com banco

Verifique se o valor de `DATABASE_URL` está correto para o modo de execução escolhido.
