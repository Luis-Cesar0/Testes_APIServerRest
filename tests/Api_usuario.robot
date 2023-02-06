*** Settings ***
Documentation    usando a Funcão de usuario da API Serverest

Resource         ../resource/main.resource

Suite Setup    start API

*** Test Cases ***
Cadastrando um novo usuário no ServeRest
    Dado que um novo usuario foi criando
    Quando o usuario estiver pronto,cadastre na ServeRest
    E confiro se o usuario foi cadastrado com sucesso
