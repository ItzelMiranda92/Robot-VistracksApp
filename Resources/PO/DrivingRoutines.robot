*** Settings ***
Library    AppiumLibrary
Resource    ../Resources/Common.robot

*** Keywords ***

Add Driving status
    changestatus.enable debug mode
    changestatus.connect to simulator

Add OffDuty status
    ${count}=   Get Matching XPath Count    xpath=//*[@text="OffDuty"]
    Run Keyword If   ${count} == 0    run keywords    changestatus.stop moving      changestatus.change status to offduty
    ...     ELSE    log to console    Already with Off Duty status

Add OnDuty ND status
    ${count}=   Get Matching XPath Count    xpath=//*[@text="OnDuty ND"]
    Run Keyword If   ${count} == 0       changestatus.change status to onduty nd
    ...     ELSE    log to console    Already with On Duty ND status

Add Sleeper status
    ${count}=   Get Matching XPath Count    xpath=//*[@text="Sleeper"]
    Run Keyword If   ${count} == 0       changestatus.change status to sleeper
    ...     ELSE    log to console    Already with Sleeper status

Add Personal Conveyance status
    ${count}=   Get Matching XPath Count    xpath=//*[@text="Personal Conveyance"]
    Run Keyword If   ${count} == 0       changestatus.change status to personal conveyance
    ...     ELSE    log to console    Already with Personal Conveyance status

Add Start Break status
    ${count}=   Get Matching XPath Count    xpath=//*[@text="END BREAK"]
    ${count2}=   Get Matching XPath Count    xpath=//*[@text="OffDuty"]
    Run keyword if   ${count} > 0       log to console    Already in Break
    ...     ELSE IF     ${count2} == 0      changestatus.change status to start break
    ...     ELSE    run keywords    changestatus.change status to onduty nd     AND     ChangeStatus.Change status to Start Break

Driving Routine One
    [Arguments]    ${user}  ${password}
    Common.Open vistracks
    Common.Accept license
    Common.Login with Driver data    ${user}      ${password}
    ChangeStatus.Verify if there are uncertified logs
    Common.Add Driving status
    sleep    10s
    changestatus.stop moving
    Common.Add OnDuty ND status
    sleep    10s
    #Common.Add Personal Conveyance status
    #sleep    10s
    #ChangeStatus.Remove Pesonal Conveyance
    #sleep    10s
    Common.Add Sleeper status
    sleep    10s
    Common.Add Start Break status
    sleep    10s
    ChangeStatus.End Break and change status to OnDuty ND
    sleep    10s
    Common.Add OffDuty status
    ChangeStatus.Disconnect from simulator
    Common.Logout

Driving Routine Test
    [Arguments]    ${user}  ${password}
    log to console    ${user}
    log to console      ${password}
    log to console    ${user}
    log to console      ${password}
    Common.Open vistracks
    Common.Accept license
    Common.Login with Driver data    ${user}      ${password}
    sleep    10s