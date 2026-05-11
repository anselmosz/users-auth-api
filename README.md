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
- [▶️ Como executar](#️-como-executar-o-projeto)

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

### Documentação (Swagger)

🔗 Docs (Swagger): [Link da docuemntação](https://users-auth-jwt-api.onrender.com/api-docs)

### A API está disponível em produção:

🔗 API: https://users-auth-jwt-api.onrender.com




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

#### Exemplo de body para registro

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

## ▶️ Como executar o projeto

#### 1 Clonar o repositório e acessar o local

```
git clone https://github.com/anselmosz/users-auth-JWT-API

cd <path to>/users-auth-JWT-API
```

#### 2 Instalar dependências

```
npm install
```

#### 3 Criar o banco de dados

Para este projeto, em testes locais usei o xampp como SGBD, utilizando o script `db_local.sql`

* Acessando o mysql via terminal, rode o seguinte comando:

```
source <path_to>/db_local.sql
```


#### 4 Configurar variáveis de ambiente

Crie um arquivo `.env` baseado no `.env.example` configurando as variáveis do seu banco rodando localmente

```
NODE_ENV=development

PORT=3000

DB_CLIENT=mysql2
DATABASE_URL=localhost
DB_PORT=3306
DB_NAME=database_name
DB_USER=db_user
DB_PASSWORD=db_password

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


#### 5 Executar o projeto

```
npm run dev
```
<!-- 
---

## Implementações futuras

O projeto ainda está em desenvolvimento, e atualmente, as funcionalidades que estão mapeadas para ser implementadas são:
- [ ] Implementar documentação gráfica com Swagger
- [ ] Adicionar refresh token
- [ ] Dockerizar aplicação
- [ ] Migrar para PostgreSQL (Para deploy de backend e banco puramente no Render)

-->
