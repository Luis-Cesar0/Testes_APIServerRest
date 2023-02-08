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
Quando cadastro o usuario na ServeRest,com:
    [Arguments]    ${email}    ${satus_code}
    ${user}    Create Dictionary
    ...        nome=Fulano da Silva    
    ...        email=${Email_teste}   
    ...        password=1234
    ...        administrador=true
    Log   ${user}
    
   ${resposta}    POST On Session    
   ...            alias=Serverest    
   ...            url=/usuarios    
   ...            json=${user}
   ...            expected_status=${satus_code}
   Log    ${resposta.json()}

   IF    ${resposta.status_code} == 201 
       Set Test Variable    ${Id_usuario}   ${resposta.json()["_id"]}
   END
   Set Test Variable    ${RESPOSTA}     ${resposta.json()}
   
         
E confiro se o usuario foi cadastrado com sucesso
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message  Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

E faço a repetição do cadastro do usuario
    Quando cadastro o usuario na ServeRest,com:  ${Email_teste}    400

E varifico se a API não permitio o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message  Este email já está sendo usado

E Consultar os dados do novo usuario
    ${RESP_Consulta}    GET On Session    Serverest    url=/usuarios/${Id_usuario}
    Set Test Variable    ${RESP_Consulta}
E verificar os dados dele
    Log    ${RESP_Consulta}
    Dictionary Should Contain Item    ${RESP_Consulta}    nome             Fulano da Silva
    Dictionary Should Contain Item    ${RESP_Consulta}    email            ${Email_teste}
    Dictionary Should Contain Item    ${RESP_Consulta}    password         1234
    Dictionary Should Contain Item    ${RESP_Consulta}    administrador    true
    Dictionary Should Contain Item    ${RESP_Consulta}    _id              ${Id_usuario}