*** Settings ***
Library                   QForce
Library                   String
Library                   DateTime
Resource                  ../resources/flows.resource
Resource                  ../resources/login_logout.resource
Resource                  ../resources/ojects.resource



*** Variables ***
${BROWSER}                chrome
${home_url}               ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example 
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order                          QForce    QWeb
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow
    Evaluate              random.seed()               random                 # initialize random generator


End suite
    Close All Browsers


Home
    [Documentation]       Navigate to homepage, login if needed
    GoTo                  ${home_url}
    ${login_status} =     IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce


NoData
    VerifyNoText          ${data}                     timeout=3                        delay=2


DeleteAccounts
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Delete
    VerifyText            Are you sure you want to delete this account?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Accounts                    partial_match=False


DeleteLeads
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Delete
    VerifyText            Are you sure you want to delete this lead?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Leads                    partial_match=False

