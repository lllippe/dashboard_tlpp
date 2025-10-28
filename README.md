🚀 **Semana 2: Configurando o Servidor REST e Criando a Primeira API em TL++**

Olá, Devs! Chegamos à segunda semana da nossa jornada! Depois de entender a arquitetura, é hora de colocar a mão na massa e configurar o coração da nossa solução: **o servidor REST do Protheus** e a nossa primeira API em **TL++**.

Nesta postagem, vamos destrinchar as configurações do appserver.ini e analisar o código que transforma dados do Protheus em um payload JSON, pronto para ser consumido pelo nosso *Front-end* em Flutter!

⚙️ **Análise do** *appserver.ini***: O Motor do REST**
O arquivo *appserver.ini* é o responsável por transformar o Application Server do Protheus em um servidor REST (HTTP Listener).

<table>
    <tr>
        <td>Seção</td>
        <td>Chave</td>
        <td>Valor</td>
        <td>Funções e Destaques</td>
    </tr>
    <tr>
        <td rowspan="2">[HTTPV11]</td>
        <td>Enable</td>
        <td>1</td>
        <td>Habilita a feature de servidor HTTP REST.</td>
    </tr>
    <tr>
        <td>Sockets</td>
        <td>HTTPREST</td>
        <td>Aponta para a seção onde a porta e segurança serão definidas.</td>
    </tr>
        <tr>
        <td rowspan="4">[HTTPREST]</td>
        <td>Port</td>
        <td>8090</td>
        <td>Define a porta que será utilizada para acesso (Ex: http://servidor:8090).</td>
    </tr>
    <tr>
        <td>Security</td>
        <td>1</td>
        <td><b>Crucial!</b> Habilita a autenticação no serviço REST.</td>
    </tr>
        <tr>
        <td>AllowBasic</td>
        <td>0</td>
        <td>Desabilita explicitamente a autenticação Basic (Usuário/Senha no Header), mas pode ser reabilitada se houver problemas na autenticação via token.</td>
    </tr>
        <tr>
        <td>URIs</td>
        <td>HTTPURI</td>
        <td>Aponta para a seção que define o path base (/rest).</td>
    </tr>
    <tr>
        <td rowspan="3">[HTTPURI]</td>
        <td>URL</td>
        <td>//rest</td>
        <td>Define o <b>caminho base</b> para todos os serviços REST (Ex: ...:8090/rest).</td>
    </tr>
    <tr>
        <td>PrepareIn</td>
        <td>01</td>
        <td>Prepara a <b>thread</b> para operar na empresa/filial 01.</td>
    </tr>
    <tr>
        <td>StateLess</td>
        <td>1</td>
        <td>Configura o serviço como Stateless, padrão REST, onde cada requisição é independente.</td>
    </tr>
    <tr>
        <td>[ONSTART]</td>
        <td>Jobs</td>
        <td>HTTPJOB</td>
        <td>Garante que o serviço será iniciado automaticamente junto com o AppServer.</td>
    </tr>
</table>

💡 **Resultado de Sucesso!** Ao subir o AppServer com essa configuração e acessar a URL base (http://IP_DO_SERVIDOR:8090/rest), obtemos a tela de login, confirmando que o servidor REST está ativo e exigindo autenticação!

💻 **Criando os Endpoints com TL++ (*dashboard.tlpp*)**
O código em TL++ é onde a mágica dos dados acontece. Utilizamos a sintaxe limpa do TL++ e as annotations de REST (@Get) para mapear funções ADVPL diretamente para endpoints da nossa API.

**Estrutura Básica:**
Cada função utiliza a annotation @Get seguida pelo nome do endpoint desejado (ex: /fanual):

@Get("/fanual")
Function u_fat_anual()
  // ... lógica de banco de dados ...
  oRest:setResponse(jResponse:toJSON()) // Retorna o JSON
Return .T.

**Destaques da Lógica (u_fat_anual como exemplo):**
<ol>
<li><b>Montagem da Query:</b> Utilizamos a função PlsQuery() com SQL padrão para consultar os dados necessários (Ex: Select SUBSTRING(E1_VENCTO, 5,2) Mes, SUM(E1_Valor) Honorarios... ).</li>
<li><b>Iteração e JSON:</b> Um laço While TRB1->(!EOF()) é usado para percorrer o resultado da consulta.</li>
<li><b>Estrutura do JSON:</b> Para cada registro, um objeto JSON (JsonObject()) é criado e preenchido.</li>
<li><b>Resposta:</b> A função oRest:setResponse(jResponse:toJSON()) empacota o array de objetos JSON e o envia como resposta HTTP.</li>
</ol>

**Endpoints Criados:**
<ul>
<li><b>/fanual</b> (Faturamento Anual)</li>
<li><b>/vreceber</b> (Valor a Receber)</li>
<li><b>/vaberto</b> (Valor em Aberto)</li>
<li><b>/fprefixo</b> (Faturamento por Prefixo)</li>
<li><b>/utitulos</b> (Últimos Títulos)</li>
</ul>

🎯 **Checklist do REST:** Todos esses endpoints estão disponíveis na lista de extensões do nosso serviço /rest!

**🔒 Próximos Passos: Autenticação e Front-end**

Com o backend configurado e os dados prontos, o foco da **Semana 3** será a criação do nosso Front-end em Flutter!

Para garantir a segurança, utilizaremos o padrão de autenticação **OAuth2** nativo do Protheus. A chamada para obtenção do token será feita no endpoint padrão:

**/api/oauth2/v1/token**

Isso é fundamental para mantermos as credenciais seguras e utilizarmos *tokens* JWT nas requisições subsequentes.

🔗 **Código Fonte**

Todos os arquivos mencionados (appserver.ini e dashboard.tlpp) estão disponíveis no meu GitHub. Sinta-se à vontade para clonar e adaptar ao seu ambiente!

GitHub: https://github.com/lllippe/dashboard_tlpp

Vejo vocês na próxima semana, quando iniciaremos o desenvolvimento em Flutter! Fiquem ligados! 🚀

**#TOTVS #RESTAPI #Integração #Flutter #TLPP #OAuth2**
