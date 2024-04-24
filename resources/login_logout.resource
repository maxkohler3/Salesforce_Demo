*** Keywords ***

Login to Salesforce
    [Documentation]       Login to Salesforce instance
    GoTo                  ${loginURL}
    TypeText              Username                    ${username}             delay=1
    TypeText              Password                    ${password}
    ClickText             Log In
    ${isMFA}=  IsText     Verify Your Identity                          
    IF  ${isMFA}                                                        
        ${mfa_code}=    GetOTP    ${username}    ${MY_SECRET}    ${password}
        TypeSecret      Code      ${mfa_code}
        ClickText       Verify
    END


Login As
    [Documentation]       Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                   before calling this keyword to change persona.
    ...                   Example:
    ...                   LoginAs    Chatter Expert
    [Arguments]           ${persona}
    ClickText             Setup
    ClickText             Setup for current app
    SwitchWindow          NEW
    TypeText              Search Setup                ${persona}             delay=2
    ClickText             User                        anchor=${persona}      delay=5    # wait for list to populate, then click
    VerifyText            Freeze                      timeout=45                        # this is slow, needs longer timeout          
    ClickText             Login                       anchor=Freeze          delay=1

