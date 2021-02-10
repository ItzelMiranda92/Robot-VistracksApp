*** Settings ***
Library    AppiumLibrary

*** Keywords ***
Verify license button loaded
    wait until element is visible    id=com.vistracks:id/acceptBtn      timeout=60
Click license button
    click element    id=com.vistracks:id/acceptBtn
Verify license text
    element should contain text    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.ScrollView/android.widget.TextView   YOUR PURCHASE AND USE OF VISTRACKS SOFTWARE IS EXPRESSLY SUBJECT TO THE TERMS AND CONDITIONS OF THIS SEPARATE AGREEMENT
Verify account name loaded
    wait until element is visible    id=com.vistracks:id/accountNameEt    timeout=60
Input Admin user
    input text    id=com.vistracks:id/accountNameEt    jtl@gmail.com
Input Admin password
    input text    id=com.vistracks:id/passwordEt   123
Input Driver user
    [Arguments]    ${user}
    input text    id=com.vistracks:id/accountNameEt    ${user}
Input Driver password
    [Arguments]   ${password}
    input text    id=com.vistracks:id/passwordEt   ${password}
Click Login button
    click element    id=com.vistracks:id/loginBtn
Wait for Syncing Account Data
    wait until element is visible    id=com.vistracks:id/syncDialogTitle  timeout=60s
    wait until page does not contain element       id=com.vistracks:id/syncDialogTitle   timeout=60s
    ${count}=   Get Matching XPath Count    xpath=//*[@text="RETRY"]
    Run Keyword If   ${count} == 0    sleep    0.5s
    ...   ELSE   sleep    0.5s

Wait for Preparing logs
    wait until element is visible    id=com.vistracks:id/splashLogoIV     timeout=45
    wait until page does not contain element       id=com.vistracks:id/splashLogoIV     timeout=45
Verify alert for Admin text
    element should contain text    id=com.vistracks:id/alertTitle   Some accounts failed to sync.
Verify message loaded
    wait until element is visible    id=com.vistracks:id/message     timeout=120
Verify message for Driver text
    element text should be     id=com.vistracks:id/message    Required data elements (Odometer, Engine Hours) were omitted in the event record.

Continue without syncing
    ${count}=   Get Matching XPath Count    xpath=//*[@text="CONTINUE WITHOUT SYNCING"]
    Run Keyword If   ${count} > 0    click element    xpath=//*[@text="CONTINUE WITHOUT SYNCING"]
    sleep    2s