*** Settings ***
Library    AppiumLibrary
Resource    PO/Login.robot
Resource    PO/ChangeStatus.robot

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4725/wd/hub
#${REMOTE_URL}     http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}    Android
${PLATFORM_VERSION}    9.0
${DEVICE_NAME}    emulator-5554
${Activity_NAME}        com.vistracks.vtlib.authentication.StartMainActivity
${PACKAGE_NAME}     com.vistracks
${AUTOMATION_NAME}  UiAutomator2
${enableMultiWindows}   true


*** Keywords ***
Open vistracks
  Open Application   ${REMOTE_URL}
  ...        platformName=${PLATFORM_NAME}
  ...    platformVersion=${PLATFORM_VERSION}
  ...   deviceName=${DEVICE_NAME}
  ...   automationName=UiAutomator2
  ...   noReset=False
  ...   autoGrantPermissions=True
    ...    newCommandTimeout=2500
    ...    appActivity=${Activity_NAME}
    ...    appPackage=${PACKAGE_NAME}

Accept license
    login.verify license button loaded
    login.click license button
    login.verify account name loaded

Check license text
    login.verify license button loaded
    login.verify license text

Login with Admin data
    login.input admin user
    login.input admin password
    login.click login button

Login with Driver data
    [Arguments]    ${user}  ${password}
    login.input driver user     ${user}
    login.input driver password     ${password}
    login.click login button
    login.wait for syncing account data
    login.wait for preparing logs
    sleep    7s

Logout
    sleep    1s
    ${count}=   Get Matching XPath Count    xpath=//android.widget.TextView[@content-desc="Logout"]
    Run Keyword If   ${count} > 0    Click Element    accessibility_id=Logout
    ...   ELSE   run keywords    Click Element    accessibility_id=More options     AND     sleep    1s     AND     Click Element   xpath=//*[@text="Logout"]
    sleep    3s
    ChangeStatus.Verify if there are uncertified logs
    wait until element is visible    xpath=//*[@text="LOGOUT"]      timeout=10
    click Element    xpath=//*[@text="LOGOUT"]
    sleep    15s
    log to console    logged out

Check successful login with Admin
    login.verify alert for admin text

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

