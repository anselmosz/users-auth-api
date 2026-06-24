-- Banco de desenvolvimento - mas pode ser adaptado para produção

-- Criação do banco - se existir, ele remove do SGBD
DROP DATABASE IF EXISTS db_auth_jwt;

-- Cria o banco com padrão utf8 unicode
CREATE DATABASE db_auth_jwt
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE db_auth_jwt;

-- Cria a tabela de contas - representa cada cliente do SaaS - cada empresa que utiliza o SaaS
CREATE TABLE accounts (
  account_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  plan ENUM('free','pro','enterprise') DEFAULT 'free',
  is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Criação da tabela de usduários - representa cada usuário pertencente a uma conta
CREATE TABLE users (
  user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  account_id BIGINT NOT NULL,

  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,

  role ENUM('admin','member') DEFAULT 'member',

  user_status ENUM('active', 'inactive') DEFAULT 'active',

  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  must_change_password BOOLEAN DEFAULT true,
  login_attempts INT DEFAULT 0,
  last_login_at DATETIME NULL,
  locked_until DATETIME NULL,

  UNIQUE(email),

  FOREIGN KEY (account_id)
    REFERENCES accounts(account_id)
    ON DELETE CASCADE -- Se o usuário for removido, isso não irá afetar outros registros do banco
);

-- Criação de indices para melhorar a performance de consultas
CREATE INDEX idx_users_account
ON users(account_id);