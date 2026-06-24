# Configuração para build da imagem da aplicação e instalação de dependências

# A imagem base é criada 
FROM node:22 AS base 
# É definido um diretório de trabalho onde a aplicação ficará armazenada
WORKDIR /app
# Os arquivos package.json, package-lock.json, e arquivos da pasta do repositório são copiados
COPY package*.json ./
# Entra em execução um comando de integração contínua do npm
RUN npm ci

# Configuração de desenvolvimento 
# cria uma "imagem" com a tag 'dev'
FROM base AS dev 
# Copia os dados do diretório da imagem "base"
COPY . . 
# Expõe a porta 4000
EXPOSE 4000
# Executa o comando `npm run dev` que é o definido na execução de ambiente de desenvolvimento
CMD ["npm", "run", "dev"]

# Configuração para produção
# Para esse projeto de teste, segue a mesma lógia do ambiente de desenvolvimento, com mudança apenas na porta de exposição e comando de execução
FROM base AS prod
COPY . .
EXPOSE 8080
CMD ["npm", "start"]