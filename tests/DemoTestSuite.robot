*** Settings ***
Resource                   ../resources/common.robot
Suite Setup                Setup Browser
Suite Teardown             End suite


*** Test Cases ***
Entering A Lead
    Home
    LaunchApp            Sales
    ClickText            Leads
    VerifyText           Change Owner
    ClickUntil           Lead Information        New

    UseModal             On                      #Only find fields from open modal dialog
    Picklist             Salutation              Mr.
    TypeText             First Name              Tim
    TypeText             Last Name               Washington
    Picklist             Lead Status             Qualified
    TypeText             Phone                   +12234567858449
    TypeText             Company                 Growmore
    TypeText             Title                   Manager
    TypeText             Email                   Tim.Washington@gmail.com
    TypeText             Website                 https://www.growmore.com/
    Picklist             Lead Source             Partner
    ClickText            Cancel                    partial_match=False
