![Logo Docker](./logo.png)

[Canal do Youtube Airton Teshima - Docker compose na Prática (Fácil)](https://www.youtube.com/watch?v=HxPz3eLnXZk)

[Link para a documentação oficial do mysql no docker hub](https://hub.docker.com/_/mysql)

[Link Dicas mysql e docker resumo](https://www.youtube.com/watch?v=X8W5Xq9e2Os)

1. O que é Docker?

> O Docker é um software de código aberto usado para implantar aplicativos dentro de containers virtuais. A conteinerização permite que vários aplicativos funcionem em diferentes ambientes complexos. Por exemplo: o Docker permite executar o WordPress em sistemas Windows, Linux e macOS, sem problemas.

### Script subindo um container mysql e mapaenado volume e portas:

```yml
# Subindo um container Mysql com Docker Compose
# CanalYoutube:https://www.youtube.com/watch?v=HxPz3eLnXZk
# LinkDocker-Hub Image mysql: https://hub.docker.com/_/mysql

version: '3.1'

services:
    db:
        # nomeando o container docker
        container_name: sisreadxls-mysql
        # baixando a imagem no docker-hub caso não exista na maquina hospedeira
        image: mysql:5.7.31
        # Esse comando séra executado assim que esse container estiver UP essa linha é recomendada
        # na documentação do docker-hub conforme explicitado no cabeçalho desse arquivo. Nada mais 
        # é que o plugin de autenticação que iremos utilizar com mysql. No mysql 8 a forma de 
        # autenticação mudou e alguns drives ainda não dão suporte 
        command: --default-authentication-plugin=mysql_native_password
        environment:
            MYSQL_ROOT_PASSWORD: root
        volumes:
          - ./dbreadxls:/var/lib/mysql
        # Caso aconteça algum problema com o container e pare o container será 
        # reiniciado automaticamente
        restart: always
        ports: 
            - '3308:3306'

```

### Comando para executar o docker-compose linux:

> Dentro da pasta onde encontra-se seu arquivo docker-compose.yml executeo comando abaixo explicitado.

```bash
docker-compose up -d
```

> Verificar se o container está rodando na máquina execute:

```bash 
docker ps
```
### Saída:

```bash
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
8166550c624a   mysql:5.7.31   "docker-entrypoint.s…"   52 minutes ago   Up 52 minutes   33060/tcp, 0.0.0.0:3308->3306/tcp, :::3308->3306/tcp   sisreadxls-mysql


```

![Logo Docker](./extensaovscode.png)

> Para manipulação de dados SQL estou utilizando a extensão MySQL - Weijan Chen
database-client.com - Database Client
### Sript SQL Manipulação do Banco de Dados:

> Neste modelo PRIMEIRO criamos a tabela de Bairros(tbl_bairros). 

```sql
# Criando a Tabela de Bairros do Município
CREATE TABLE
    tbl_bairros(
        id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
        bairro VARCHAR(80)
    );
```

> SEGUNDO passo é criar a tabela de ruas já fazendo o relacionamento entre as duas tabelas.

```sql
# Criando a Tabela de Ruas do Município
CREATE TABLE
    tbl_ruas(
        id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
        rua VARCHAR(80),
        pkidbairro int,
        CONSTRAINT fk_RuasBairros FOREIGN KEY(pkidbairro) REFERENCES tbl_bairros(id)
    );
```

> TERCEIRO passo criar a tabela de usbs que terá dois relacionamento estrangeiros dentro dela.

```sql
# Criando a Tabela de cadastro das Usbs do Município
CREATE TABLE
    tbl_usbs(
        id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
        nome VARCHAR(80),
        pkidrua int,
        pkidbairro int,
        CONSTRAINT fk_UsbsBairros FOREIGN KEY(pkidbairro) REFERENCES tbl_bairros(id),
        CONSTRAINT fk_UsbsRuas FOREIGN KEY(pkidrua) REFERENCES tbl_ruas(id)
     );
```

> QUARTO passo é inserir alguns registros na tabela de bairros.

```sql
#*****************************************
# 1- Inserindo dados iniciais na tabela #
#*****************************************
INSERT INTO tbl_bairros (bairro)VALUES('CENTRO');
INSERT INTO tbl_bairros (bairro)VALUES('TUCUM');
INSERT INTO tbl_bairros (bairro)VALUES('SANTO ANTONIO');    
```

> QUINTO passo é inserir alguns registros na tabela ruas.

```sql
#*****************************************
# 2- Inserindo dados iniciais na tabela #
#*****************************************
INSERT INTO tbl_ruas (rua,pkidbairro)VALUES('TRAVESSA DICO VEIGA',1);
INSERT INTO tbl_ruas (rua,pkidbairro)VALUES('SATUBAL',1);
INSERT INTO tbl_ruas (rua,pkidbairro)VALUES('AVENIDA RODOVIARIA',1);
INSERT INTO tbl_ruas (rua,pkidbairro)VALUES('COMERCIO',1);
```

> SEXTO passo é inserir alguns registros na tabela usbs.

```sql
#*****************************************
# 3- Inserindo dados iniciais na tabela #
#*****************************************
INSERT INTO tbl_usbs (nome,pkidrua,pkidbairro)VALUES('DICO VEIGA',1,1);
INSERT INTO tbl_usbs (nome,pkidrua,pkidbairro)VALUES('OZIMA VIEIRA',2,1);
INSERT INTO tbl_usbs (nome,pkidrua,pkidbairro)VALUES('VILLE',3,1);

```