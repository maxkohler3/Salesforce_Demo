*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***

TC1
    [Documentation]    Cisco Workshop
    Appstate           Login
    ClickText    App Launcher
    TypeText     Search apps and items...    cred
    ClickText    Credentials
    ClickText    Select List View
    ClickText    Selected

Dev Console
    Appstate        Login
    ClickText       Setup
    ClickText       Developer Console
    SwitchWindow    2
    ClickText       Query Editor
    ClickText       Enter SOQL
    TypeText        Enter SOQL     SELECT Id, Name, Territory2Id, Territory2.Sub_Sales_Coverage_Code_c, CreatedDate FROM opportunity WHERE id = '0067d00000Ka1EbAAJ'
    ClickText       Execute

Get OppID from URL
    ${url}=   GetUrl
    Log       ${url}
    ${OppID}=    Fetch From Right   ${url}  between=lightning/???/home
    Log          ${OppID}
    SwitchWindow             2
    
