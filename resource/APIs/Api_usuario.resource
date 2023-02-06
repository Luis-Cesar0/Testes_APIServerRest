*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Keywords ***
Dado que um novo usuario foi criando
    ${PALAVRA-ALEATORIAS}    Generate Random String    length=4    chars=[LETTERS]
    ${PALAVRA-ALEATORIAS}    Convert To Lower Case    ${PALAVRA-ALEATORIAS}
    Set Test Variable    ${Email_teste}     ${PALAVRA-ALEATORIAS}@emailtest.com
    Log    ${Email_teste}

Quando o usuario estiver pronto,cadastre na ServeRest
    ${user}    Create Dictionary
    ...        nome=Fulano da Silva    
    ...        email=${Email_teste}    
    ...        password=1234
    ...        administrador=true
    Log   ${user}
    
   ${resposta}    POST On Session    alias=Serverest    url=/usuarios    json=${user}
   Log    ${resposta}
   Set Test Variable    ${RESPOSTA}    ${resposta.json()}
         
E confiro se o usuario foi cadastrado com sucesso
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message  Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id