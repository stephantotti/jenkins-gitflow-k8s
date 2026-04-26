# 📦 Makefile (DevOps + Docker + Terraform + CI/CD)

# =========================================

# 🔤 VARIÁVEIS (atalhos reutilizáveis)

# =========================================

APP_NAME = minha-app
IMAGE_NAME = minha-app
CONTAINER_NAME = minha-app-container
PORT = 3000

# Uso das variáveis:

# $(APP_NAME) → substitui pelo valor definido acima

# =========================================

# 📦 INSTALAR DEPENDÊNCIAS

# =========================================

install:
# Executa instalação (exemplo com Node)
npm install

# =========================================

# ▶️ RODAR LOCALMENTE

# =========================================

run:
# Sobe a aplicação local
npm start

# =========================================

# 🧪 TESTES

# =========================================

test:
# Executa testes automatizados
npm test

# =========================================

# 🏗️ BUILD

# =========================================

build:
# Gera versão de produção
npm run build

# =========================================

# 🧹 LIMPEZA

# =========================================

clean:
# Remove arquivos gerados
rm -rf node_modules dist

# =========================================

# 🐳 DOCKER - BUILD

# =========================================

docker-build:
# Cria imagem Docker
docker build -t $(IMAGE_NAME) .

# =========================================

# 🐳 DOCKER - RUN

# =========================================

docker-run:
# Roda container em background
docker run -d -p $(PORT):$(PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

# =========================================

# 🐳 DOCKER - STOP / REMOVE

# =========================================

docker-stop:
# Para container
docker stop $(CONTAINER_NAME)

docker-rm:
# Remove container
docker rm $(CONTAINER_NAME)

# =========================================

# ☁️ TERRAFORM

# =========================================

tf-init:
# Inicializa o Terraform
terraform init

tf-plan:
# Mostra mudanças
terraform plan

tf-apply:
# Aplica infraestrutura
terraform apply -auto-approve

tf-destroy:
# Destroi infraestrutura
terraform destroy -auto-approve

# =========================================

# 🚀 PIPELINE LOCAL (simula CI/CD)

# =========================================

pipeline:
# Executa comandos em sequência
make install
make test
make build
make docker-build

# =========================================

# 🎯 .PHONY

# =========================================

# O Makefile funciona baseado em ARQUIVOS.

# Exemplo:

# Se existir um arquivo chamado "build" na pasta,

# o make pode achar que o alvo "build" já está "pronto"

# e NÃO executar o comando.

# 👉 Problema real:

# arquivo chamado "build" existe → make build não roda

# 👉 Solução: usar .PHONY

# .PHONY diz:

# "isso aqui NÃO é arquivo, é um comando que deve rodar sempre"

.PHONY: install run test build clean docker-build docker-run docker-stop docker-rm tf-init tf-plan tf-apply tf-destroy pipeline

# =========================================

# 📌 QUANDO USAR .PHONY

# =========================================

# Use .PHONY para:

# ✔ comandos (run, test, deploy, clean, etc)

# ✔ automações

# ✔ pipelines

# NÃO precisa usar para:

# ❌ arquivos reais gerados (ex: app, build.zip, etc)

# =========================================

# 🧪 EXEMPLO PRÁTICO DO PROBLEMA

# =========================================

# ERRADO (sem .PHONY):

#

# build:

# echo "fazendo build"

#

# Se existir um arquivo chamado "build",

# esse comando pode NÃO rodar.

# CORRETO:

#

# .PHONY: build

#

# build:

# echo "fazendo build"

# =========================================

# 🧱 FORMATAÇÃO (MUITO IMPORTANTE)

# =========================================

# 1. O comando DEVE começar com TAB (não espaços)

#

# ERRADO:

# build:

# echo "isso quebra"

#

# CORRETO:

# build:

# echo "isso funciona"

# 2. Cada linha é executada em um shell separado

#

# Exemplo:

#

# errado:

# multi:

# cd pasta

# ls

#

# (ls roda fora da pasta)

# correto:

multi:
cd pasta && ls

# 3. Evitar exibir comando (usar @)

#

# normal:

# echo:

# echo "Oi"

#

# saída:

# echo "Oi"

# Oi

#

# com @:

# echo:

# @echo "Oi"

#

# saída:

# Oi

# =========================================

# 💡 COMANDOS ÚTEIS

# =========================================

# Listar targets disponíveis:

# make help (se você criar um alvo help)

help:
@echo "Comandos disponíveis:"
@echo "make install        - instalar dependências"
@echo "make run            - rodar app"
@echo "make test           - rodar testes"
@echo "make build          - buildar projeto"
@echo "make docker-build   - build docker"
@echo "make docker-run     - rodar container"
@echo "make tf-apply       - aplicar terraform"

.PHONY: help
