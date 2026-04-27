Sistema de Extração de Sintomas para Vigilância Sindrômica

Criado pela Assessoria de Tecnologia da SMS Florianópolis.
Contato: assessoria.sms@pmf.sc.gov.br



Este sistema foi desenvolvido para automatizar a extração de sintomas da evolução clínica utilizando LLM local.


⚙️ Fluxo de Funcionamento

1. O sistema recebe na variável "prontuarios" com os dados do atendimento.
2. Os dados são tratados e é verificado se o nr_atendimento já existe no banco de dados opas_db. Essa etapa é para evitar que o mesmo atendimento seja processado duas vezes.
3. Os atendimentos restantes são enviados para o LLM para a extração dos sintomas.
4. Na última etapa os dados são recebidos do llm e salvos no banco de dados.


🛠️ Configuração e Instalação
Siga as etapas abaixo para preparar o ambiente:



1. Configuração do Ollama
    1.1 Instale o Ollama.

    1.2 Acesse as configurações (Settings).

    1.3 Habilite a opção "Expose Ollama to the network".

    1.4 No arquivo config.toml do projeto, insira o endereço IP do seu servidor Ollama.



2. Banco de Dados
    2.1 Suba uma instância do servidor MariaDB.

    2.2 Importe o arquivo db_opas.sql para criar a estrutura necessária do banco de dados.

    2.3 Insira as credenciais de acesso (host, usuário, senha) no arquivo config.toml.



3. Instalação de Dependências e Modelo
    Execute o notebook instalador.ipynb. Este script automatiza:

    3.1 A instalação das bibliotecas Python necessárias.

    3.2 O download e configuração do modelo de LLM.

    Modelo Padrão: qwen2.5:14b-instruct



4. No arquivo "vigilancia_sindromica.ipynb" insira a lógica de acesso ao seu banco de dados para extrair as informações necessárias.

    Crie uma variável chamada "prontuario" no formato Pandas DataFrame, Dicionário ou Lista de Dicionários com os dados do atendimento.

    Envie a variável para a função enviar_llm(tratar_prontuarios()) conforme exemplo abaixo:

        Exemplo: enviar_llm(tratar_prontuarios(prontuarios))




📊 Estrutura de Dados
O sistema é flexível e aceita dados de atendimento nos formatos de Pandas DataFrame, Dicionário ou Lista de Dicionários. 

Os campos obrigatórios são:

nr_atendimento: Identificador único do atendimento

unidade: Nome da unidade de saúde.

data_hora_atendimento: Data e hora do registro.

dt_nascimento: Data de nascimento do paciente.

sg_sexo: Sexo biológico (Ex: M/F).

cid10: Código Internacional de Doenças.

evolucao: Campo Principal --> Texto livre de onde os sintomas serão extraídos.

uf: Unidade Federativa.

municipio: Cidade do atendimento.

bairro: Bairro do paciente.