*** Settings ***
Documentation  This is a basic test suite for mobile testing with RobotFramework
Resource    ../Resources/Common.robot

*** Test Cases ***
Verify License
    [Documentation]    Verify that the license is displayed before logging in and that the text is correct
    [Tags]    Login
    Common.Open vistracks
    Common.Check license text

Login with Driver
    [Documentation]     Verify that a Driver type user can log into the app
    [Tags]    Login
    Common.Open vistracks
    Common.Accept license
    Common.Login with Driver data

Login with Admin
    [Documentation]     Verify that an Admin type user can log into the app
    [Tags]    Login     Smoke   Demo
    Common.Open vistracks
    Common.Accept license
    Common.Login with Admin data
    Common.Check successful login with Admin

