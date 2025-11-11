# 🚀 Dashboard Financeiro Ágil: Protheus (TL++) + Flutter

<p align="center">
  <img src="https://img.shields.io/badge/Protheus-TL++-blue" alt="Protheus TL++">
  <img src="https://img.shields.io/badge/Frontend-Flutter-46c0e5" alt="Frontend Flutter">
  <img src="https://img.shields.io/badge/API-REST-success" alt="API REST">
  <img src="https://img.shields.io/badge/Autenticação-OAuth2-orange" alt="Autenticação OAuth2">
</p>

Este projeto é o resultado da série de três semanas **"Protheus + Flutter em 3 Semanas"**, onde demonstramos a construção de um Dashboard de Gestão Financeira com alta performance. O objetivo é modernizar o consumo de dados consolidados do Protheus, utilizando o AppServer como uma camada de API leve e o Flutter para uma experiência mobile fluida e nativa.

## 🎯 Visão Geral do Projeto

A solução resolve a lentidão no acesso a dados consolidados no ERP, fornecendo uma interface de usuário moderna e otimizada, capaz de carregar informações em tempo real (como Faturamento, Contas a Receber e Saldo em Aberto) diretamente do Protheus.

### 🧩 Stack de Tecnologia

* **Backend (ERP API):** TOTVS Protheus, AppServer, ADVPL/TL++ (utilizando `WSRESTFUL` e `PlsQuery`).
* **Banco de Dados:** SQL Server (ou o banco de dados configurado no ambiente Protheus).
* **Frontend (Mobile):** Flutter / Dart.
* **Comunicação:** REST (padrão JSON).
* **Segurança:** OAuth2 nativo do Protheus.

## 📂 Estrutura do Repositório

O repositório está dividido em duas pastas principais para separar as camadas da aplicação:
```
dashboard_tlpp/
├── appserver.ini    # Configuração do AppServer para subir o REST.
├── dashboard.tlpp   # Código fonte em TL++ com os endpoints da API.
└── dashboard_tlpp/  
    ├── lib/         # Código fonte da aplicação Flutter (Layout, Telas, Conexão).  
    ├── pubspec.yaml # Dependências do Flutter.
    └── ...          # Outros arquivos de projeto Flutter.
```
##
## ⚙️ Backend Protheus: Configuração e TL++

### 1. Configuração do AppServer (`appserver.ini`)

A configuração abaixo transforma a *thread* do AppServer em um Listener HTTP/REST, configurando a porta e forçando a segurança.

**Destaques:**

* **`[HTTPREST]`**: Define a `Port` (`8090`) e habilita a `Security=1`.
* **`[HTTPURI]`**: Define o caminho base da API (`URL=/rest`) e força a preparação do ambiente na filial `01` (`PrepareIn=01`).
* **`[ONSTART]`**: Garante que o serviço HTTPJOB seja iniciado automaticamente.

```ini
[HTTPV11]
Enable=1
Sockets=HTTPREST
Environment=HOMOLOG

[HTTPREST]
Port=8090
IPsBind=
Security=1
AllowBasic=0
URIs=HTTPURI
ResponseTimeOut=300

[HTTPURI]
URL=/rest
PrepareIn=01
Instances=1,1
CORSEnable=1
AllowOrigin=*
StateLess=1

[HTTPJOB]
MAIN=HTTP_START
Environment=HOMOLOG

[ONSTART]
Jobs=HTTPJOB
```

### 2. Implementação da API (dashboard.tlpp)

O arquivo dashboard.tlpp utiliza o framework WSRESTFUL do Protheus para mapear funções TL++ a endpoints REST, utilizando a annotation @Get. Todas as consultas são realizadas via PlsQuery na tabela SE1010 (Contas a Receber) para garantir a performance.

### 3. Compilação 

Para que os endpoints funcionem:
* Compile o arquivo dashboard.tlpp no RPO do ambiente configurado (HOMOLOG).
* Reinicie a instância do AppServer que está rodando o serviço REST.

### 📞 Endpoints da API

Todos os endpoints utilizam o caminho base /rest e retornam um array de objetos JSON:
<table>
    <tr>
        <td><b>Método</b></td>
        <td><b>Endpoint</b></td>
        <td><b>Descrição</b></td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/rest/fanual</td>
        <td>Retorna o Faturamento e Saldo Anual por Mês.</td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/rest/vreceber</td>
        <td>Retorna o Valor Consolidado a Receber no período.</td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/rest/vaberto</td>
        <td>Retorna o Valor Consolidado de Saldo em Aberto no período.</td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/rest/fprefixo</td>
        <td>Retorna o Faturamento Consolidado por Prefixo de Título.</td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/rest/utitulos</td>
        <td>Retorna os últimos 10 Títulos com detalhes do cliente e valores.</td>
    </tr>
</table>

##

### 🔒 Autenticação (OAuth2)

A comunicação entre o Flutter e o Protheus é totalmente segura, utilizando o protocolo OAuth2.

O primeiro passo é obter o token de acesso (JWT) através do endpoint padrão do Protheus:

POST /api/oauth2/v1/token

O token recebido deve ser enviado em todas as requisições subsequentes no Header Authorization (padrão Bearer).

##

### 📱 Frontend Flutter

O código no diretório frontend-flutter contém a aplicação que consome os endpoints acima.

Pré-requisitos:
* Flutter SDK instalado.
* Dependências instaladas (Execute flutter pub get na pasta frontend-flutter).
* Configuração da URL base da API no código do Flutter para apontar para o seu AppServer Protheus (http://IP_DO_SERVIDOR:8090/rest).

### 🤝 Contribuições
Sinta-se à vontade para enviar sugestões, pull requests ou reportar issues. Este projeto visa ser um guia prático para a integração Protheus + Tecnologias Modernas!
