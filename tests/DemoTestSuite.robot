*** Settings ***
Resource                   ../resources/common.robot
Suite Setup                Setup Browser
Suite Teardown             End suite


*** Test Cases ***
Test Opportunity components
    Home
    ClickText              Opportunities
    ClickText              Select a List View
    ClickText              All Opportunities
    TypeText               Search this list...         Growmore
    Hotkey                 enter

    ClickText              List View Controls
    ClickText              New                        anchor=Clone      delay=2
    UseModal               On
    VerifyText             List Name
    VerifyText             List API Name
    VerifyText             Who sees this list view?
    ClickText              Cancel
    UseModal               Off
    ClickText              Display as Table
    ClickText              Kanban
    VerifyText             Display as Kanban
    LogScreenshot

    ClickText              Display as Kanban
    ClickText              Table
    ClickText              Refresh

    ClickText              Growmore Pace
    ClickText              Show more actions
    ClickText              Change Owner
    UseModal               On
    VerifyText             Change Opportunity Owner
    VerifyText             The new owner will also become the owner of these records related to Growmore Pace that are owned by you.
    ClickText              Cancel
    UseModal               Off

    ClickText              New Case                    
    UseModal               On
    PickList               Status                      Escalated
    TypeText               Subject                     New Case Demo
    TypeText               Description                 enter some info
    ClickText              Cancel
    UseModal               Off

    ClickText              Details
    VerifyField            Opportunity Name            Growmore Pace
    VerifyField            Stage                       Prospecting
    VerifyField            Probability (%)             10%
    VerifyField            Close Date                  12/31/2021
    VerifyField            Opportunity Owner           Max Kohler           partial_match=true                     
    VerifyField            Account Name                Growmore             partial_match=true
