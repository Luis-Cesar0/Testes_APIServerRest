*** Settings ***
Documentation     Arquivo principal do teste

Resource    APIs/Api_usuario.resource

*** Keywords ***
start API
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json 
    Create Session    Serverest    https://serverest.dev    headers=${headers}