*** Settings ***
Library                   QWeb
Library                   QForce
Library                   QVision
Library                   String
Library                   DateTime
Library                   FakerLibrary


*** Variables ***
${BROWSER}               chrome
${username}              mkohler+crt@copado.com.maxtest
${login_url}             https://copadocrt--maxtest.my.salesforce.com/            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}              ${login_url}/lightning/page/home
${first_name}            Thomas 


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow


End suite
    Close All Browsers


Login
    [Documentation]      Login to Salesforce instance
    GoTo                 ${login_url}
    TypeText             Username                    ${username}             delay=1
    TypeText             Password                    ${password}
    ClickText            Log In
    ${isMFA}=  IsText     Verify Your Identity                                    #Determines MFA is prompted
    Log To Console                       ${isMFA}
     IF   ${isMFA}                                                        #Conditional Statement for if MFA verification is required to proceed
          ${mfa_code}=    GetOTP    ${username}    ${MY_SECRET}    ${password}
          TypeSecret      Code      ${mfa_code}
          ClickText       Verify
    END

    ${isLoginSuccess}=   IsText   Home
     IF                ${isLoginSuccess}
         VerifyText    Home
    END


Home
    [Documentation]      Navigate to homepage, login if needed
    GoTo                 ${home_url}
    ${login_status} =    IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If       ${login_status}             Login
    ClickText            Home
    VerifyTitle          Home | Salesforce


MFA Login
    ${isMFA}=  IsText     Verify Your Identity                                    #Determines MFA is prompted
    Log To Console                       ${isMFA}
     IF   ${isMFA}                                                        #Conditional Statement for if MFA verification is required to proceed
          ${mfa_code}=    GetOTP    ${username}    ${MY_SECRET}    ${password}
          TypeSecret      Code      ${mfa_code}
          ClickText       Verify
    END

    ${isLoginSuccess}=   IsText   Home
     IF                ${isLoginSuccess}
         VerifyText    Home
    END


# Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]       Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]           ${text}                     ${selected}=true
    VerifyElement         //a[@title\="${text}" and @aria-checked\="${selected}"]


NoData
    VerifyNoText          ${data}                     timeout=3                        delay=2


DeleteAccounts
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Show more actions
    ClickText             Delete
    VerifyText            Are you sure you want to delete this account?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Accounts                    partial_match=False


DeleteLeads
    [Documentation]       RunBlock to remove all data until it doesn't exist anymore
    ClickText             ${data}
    ClickText             Show more actions
    ClickText             Delete
    VerifyText            Are you sure you want to delete this lead?
    ClickText             Delete                      2
    VerifyText            Undo
    VerifyNoText          Undo
    ClickText             Leads                    partial_match=False

