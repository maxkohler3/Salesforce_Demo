*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Dev Console
    Appstate             Login
    ClickText    Setup
    SwitchWindow         2
    #ClickText    Opens in a new tab
    ClickText    File
    ClickText       Query Editor
    TypeText        Enter SOQL or SOSL query: SELECT columns FROM type WHERE predicates | FIND what IN type FIELDS RETURNING type(columns)[...]    SELECT Id, Name, Territory2Id, Territory2.Sub_Sales_Coverage_Code_c, CreatedDate FROM opportunity WHERE id = '0067d00000Ka1EbAAJ'
    ClickText       Execute

    SwitchWindow         1
    ${url}=   GetUrl
    Log       ${url}
    ${OppID}=    GetText     https://copadocrt--maxtest.lightning.force.com/    between=lightning/???/home
    SwitchWindow             2
    
