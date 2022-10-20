# mba_projeto_aplicado
Esse repositório possui todo o código fonte necessário para o desenvolvimento do TCC da MBA em Engenharia de Dados.
O objetivo desse repositório é deixar um código preparado para subir um ambiente no Azure e uma documentação de como desenvolver um processo de engenharia de dados, o código disponibilizado vai ser responsável pelos seguintes recursos:

## 01_terraform_starter_resources
- Grupo de recursos
- Data Lake 
    - Adição de uma regra para que o Terraform possa criar recursos nesse Data Lake
    - Criação dos container raw e infra

## 02_terraform_resources_cloud
- terraform.tfstate
    - Configurar o arquivo de estado, que no 01_terraform_starter_resources era local, para o Data Lake (Container de Infra)
- Databricks
    - Criação do recurso
- Data Factory
    - Criação do recurso

## 03_terraform_databricks
- terraform.tfstate
    - Configurar o arquivo de estado, que no 01_terraform_starter_resources era local, para o Data Lake (Container de Infra)

Antes de executar o Terraform, você precisa criar o token do Databricks antes de prosseguir, para criar o token, use a documentação: https://docs.microsoft.com/pt-br/azure/databricks/dev-tools/api/latest/authentication
- Databricks
    - Criação do Cluster de desenvolvimento
- Data Factory
    - Criação do Linked Service (usado para conectar o Data Factory ao Databricks)

Antes de executar qualquer código, abra os arquivos e faça as edições necessárias, o código está totalmente comentado, para que você saiba exaramente o que editar.

Após executar todos os scripts, você terá criado um ambiente no Azure que vai permitir fazer processos de engenharia de dados, mas antes de começar a desenvolver, você precisa fazer um passo manualmente, que é a criação dos pontos de montagens necessários.
O ponto de montagem é o que permite o Databricks a acessar os dados do Data Lake, até o momento, essa parte não foi automatizada, para executa-la, você pode seguir o seguinte tutorial no YouTube, que foi produzido pelo dono do repositório atual: https://www.youtube.com/watch?v=40Di8NKRjP4&t=61s

## Ideias de como desenvolver um bom processo de ETL:
### Data Lake
No Data Lake, o ideal é a existencia de 3 container, cada um usado para um objetivo:
raw (bronze): Dados cru, você simplesmente extrai o dado e coloca aqui
silver: Aqui você vai colocar seus dados normalizados e filtrados
gold: Camada final, onde vamos disponibilizar os dados agregados e com os joins necessários, para entregar nossas dimensões e nossas fatos.

### Organização de pastas (Databricks, Data Factory, Data Lake)
Para que tenhamos uma arquitetura bem organizada, precisamos de uma série de padrões, recomendamos usar o mesmo padrão de organização para todas as ferramentas, aqui segue um exemplo de organização, adaptea a sua necessidade:
[Sistema] > [Relatório]

Exemplo de pastas no Databricks:
SAP > Vendas > web_bz_vendas
SAP > Vendas > bz_sv_vendas
SAP > Vendas > sv_gd_vendas

Note que no caso do Databricks separamos o desenvolvimento em 3 arquivos, isso ajuda a liberar recursos e deixar nosso código melhor organizado, mas no caso do Data Factory, podemos ter apenas 1 pipeline de orquestração, organizado da seguinte maneira:
SAP > Vendas > web_gd_vendas

No caso do Data Lake, ficaria apenas:
SAP > Vendas

Sendo que cada pasta, estária em um container, 1 para raw, 1 para silver e 1 para gold.

### Desenvolvimento de código
Um dos maiores problemas que podemos encontrar, são código mal escritos, por isso recomendamos que você pesquise sobre Clean Code, sim o livro, não precisa ler o livro, existe conteudos em vídeo explicando boas práticas do livro, entre elas:
- Padronize a escrita: Leia sobre camelCase, snake_case, etc. 
- Bons nomes em variaveis/funções: Nomes de variaveis e funções que expliquem o que elas realmente fazem, isso ajuda a entender um código.
- Padronize a linguagem de desenvolvimento seja Python, Scala, SQL, padronize para que não exista desenvolvimentos feitos de qualquer maneira.
- Leia a PEP8, é guia de estilo para desenvolvimento em Python, ou seja, lhe ensina a escrever um bom código: https://peps.python.org/pep-0008/

Referencia de arquitetura: https://learn.microsoft.com/pt-br/azure/architecture/solution-ideas/articles/azure-databricks-modern-analytics-architecture