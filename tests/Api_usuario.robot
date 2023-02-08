*** Settings ***
Documentation    usando a Funcão de usuario da API Serverest

Resource         ../resource/main.resource

Suite Setup    start API

*** Test Cases ***
Cadastrando um novo usuário no ServeRest
    Dado que um novo usuario foi criando
    Quando cadastro o usuario na ServeRest,com:    ${Email_teste}    201
    E confiro se o usuario foi cadastrado com sucesso

Cadastrando um usuario exitente
    Dado que um novo usuario foi criando
    Quando cadastro o usuario na ServeRest,com:    ${Email_teste}    201
    E faço a repetição do cadastro do usuario
    E varifico se a API não permitio o cadastro repetido

Consultar os dados de um novo usuario
    Dado que um novo usuario foi criando
    Quando cadastro o usuario na ServeRest,com:    ${Email_teste}    201
    E Consultar os dados do novo usuario
    # E verificar os dados dele