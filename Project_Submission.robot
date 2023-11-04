*** Settings ***
Documentation       This Test Suite performs project submission in UI
Library             SeleniumLibrary
Library             String
Test Setup          Given provided URL is accessed

***Variables***
${URL}               https://automationinterface1.front.staging.optimy.net/en/
${Login_Username}    optimyautomationtester@gmail.com
${Login_Password}    yRMhojb7
${file_path}         C:\\Users\\nayaksu\\OneDrive - Tecnotree\\Desktop\\DSA_Practice\\MyAutomation\\Eastvantage_Test\\Image.jpg

***Test Cases***

# Feature: Project Submission Process

New Project Submission Workflow

    Given provided URL is accessed
    Then login is performed using the supplied login credentials
    And the action of clicking the Submit a new application button is initiated
    Then, in the event that the "Continue with the submission of the application" prompt is visible
    And the submission of a new application is triggered by selecting the corresponding button located at the bottom
    And all mandatory forms are completed with the required data
    And navigation to the subsequent screen is executed by selecting the "Next screen" button
    Then a validation check is performed to ensure that all the provided input values are correctly displayed in the Summary screen
    And the submission process is executed by selecting the "Validate and send" button
    Then successful redirection to the "Thank you for submitting your project" page is verified


***Keywords***

Given provided URL is accessed

    Open browser    ${URL}      Chrome      chromedriver.exe        options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep   5s
    Wait Until Element Is Enabled       CSS:#cookie-close-button
    Double Click Element   CSS:#cookie-close-button

Then login is performed using the supplied login credentials

    Wait Until Element Is Enabled       //a[text()='Login']        10s
    Click Element       //a[text()='Login']
    Input Text          CSS:#login-email        ${Login_Username}
    Input Password      CSS:#login-password     ${Login_Password}
    Click Element       CSS:button[class="btn btn-lg btn-primary col-12 mt-1 mt-md-2"]
    Log To Console      Executed

And the action of clicking the Submit a new application button is initiated

    Log To Console      Executed
    Click Element       CSS:a[class="nav-link d-block "]

Then, in the event that the "Continue with the submission of the application" prompt is visible

    ${continue_button_present} =   Run Keyword And Return Status   Element Should Be Visible   //a[contains(text(), 'Continue with the submission of the application')]
    Set global variable     ${continue_button_present}

And the submission of a new application is triggered by selecting the corresponding button located at the bottom

    Run Keyword If   ${continue_button_present}    Click Element   (//a[contains(text(), 'Submit a new application')])[3]

And all mandatory forms are completed with the required data

    ${FirstName}=         generate random string      6      ABCDEF
    Set global variable     ${FirstName}
    ${LastName}=         generate random string      6      GHIJKL
    Set global variable     ${LastName}
    ${Address}=           generate random string      6      MNOPQR
    Set global variable     ${Address}
    Input Text      id:629d7b5a-f6a1-5a14-ac1d-21b2fafdbdef       ${FirstName}
    Input Text      id:23e5e47e-bab1-5a1e-9929-f180182bda43       ${LastName}
    Input Text      id:7172c3f2-f508-5f9c-82a1-11ce9d0f3edc::c3f44a2e-72e9-587b-b88c-b5c9fbeed2db       ${Address}
    ${input_locator} =    Set Variable    //input[@aria-label="Select postal code"]
    Input Text    ${input_locator}    1000
    Wait Until Element Is Enabled    //li/a[@class='ui-corner-all']      10s
    Click Element       //li/a[@class='ui-corner-all']
    Sleep   2s
    Click Element      //select/option[@value='AF']
    Execute JavaScript    document.querySelector('input[type="file"]').style.display = 'block';
    Choose File     xpath://input[@type='file']     ${file_path}
    Sleep  5s
    Wait Until Element Is Enabled       //div[contains(text(), 'Male')]       10s
    Click Element     //div[contains(text(), 'Male')]
    Sleep   2s
    Click Element     //select[@id="field_f801d7d8-0762-5407-95f9-b8c3a793157c"]
    Sleep   2s
    Click Element     //select/option[@value='6365118b-637a-5297-b56d-e7c8b9a60ce0']
    Wait Until Element Is Enabled       //div[contains(text(), 'JIRA')]       10s
    Click Element     //div[contains(text(), 'JIRA')]
    Wait Until Element Is Enabled       //div[contains(text(), 'Test management tool')]       10s
    Click Element     //div[contains(text(), 'Test management tool')]
    Wait Until Element Is Enabled       //div[contains(text(), 'MySQLi')]       10s
    Click Element     //div[contains(text(), 'MySQLi')]
    Wait Until Element Is Enabled       //div[contains(text(), 'Python')]      10s
    Click Element     //div[contains(text(), 'Python')]
    Wait Until Element Is Enabled       //div[contains(text(), 'Robot')]        10s
    Click Element     //div[contains(text(), 'Robot')]
    ${Random_Text}=           generate random string      30      ABCDEFHILJYTIHUECF
    Set global variable     ${Random_Text}
    Select Frame        //iframe[@title="Editor, 91296806-02e6-5bb5-bac0-deb4cbf64a64::42b16795-740d-5d97-b972-a3643510eb01"]
    Input Text          //body[@class='cke_editable cke_editable_themed cke_contents_ltr cke_show_borders']       ${Random_Text}
    Unselect Frame

And navigation to the subsequent screen is executed by selecting the "Next screen" button

    Click Button        CSS:#navButtonNext

Then a validation check is performed to ensure that all the provided input values are correctly displayed in the Summary screen

    Wait Until Element Is Enabled           (//div[@class='form-group answers'])[1]     10s
    ${Summary_First_name} =    Get Text    (//div[@class='form-group answers'])[1]
    Should Be Equal As Strings    ${Summary_First_name}    ${FirstName}
    Log To Console      Firat Name is correct ${Summary_First_name}
    ${Summary_Last_name} =    Get Text    (//div[@class='form-group answers'])[2]   
    Should Be Equal As Strings    ${Summary_Last_name}    ${LastName}
    Log To Console      Last name is correct ${Summary_Last_name}
    ${Summary_Address} =    Get Text    (//div/p[@class='mb-0'])[3]   
    Should Be Equal As Strings    ${Summary_Address}    ${Address}
    Log To Console      Address is correct ${Summary_Address}
    ${Summary_Postal_Code} =    Get Text    CSS:#container_e57df0b5-c2ad-514a-967f-ee8b962f5ed4
    Should Contain    ${Summary_Postal_Code}    1000
    Log To Console      Postal code is correct ${Summary_Postal_Code}
    ${Summary_Country} =    Get Text    CSS:#container_7e595970-fc12-558c-9eaf-385735fcae6b
    Should Contain      ${Summary_Country}      Afghanistan
    Log To Console      Country is correct ${Summary_Country}
    ${Summary_Gender} =    Get Text    CSS:#container_f3fa11a5-a516-5cec-9025-b940b1b113d0
    Should Contain      ${Summary_Gender}      Male
    Log To Console      Gender is correct ${Summary_Gender}
    ${Summary_Role} =    Get Text    (//div/p[@class='answer view mb-0 '])
    Should Contain      ${Summary_Role}      Manual + Au
    Log To Console      Role is correct ${Summary_Role}
    ${Summary_Objective} =    Get Text    CSS:#container_91296806-02e6-5bb5-bac0-deb4cbf64a64
    Should Contain      ${Summary_Objective}        ${Random_Text}      
    Log To Console      Role is correct ${Random_Text}

And the submission process is executed by selecting the "Validate and send" button

    Wait Until Element Is Enabled       (//button[@type='submit'])[4]       10s
    Click Button        (//button[@type='submit'])[4]

Then successful redirection to the "Thank you for submitting your project" page is verified

    Wait Until Element Is Enabled       (//div/h1[@class='h1 text-center'])     10s
    ${Final_Confirm_Msg} =      Get Text     (//div/h1[@class='h1 text-center'])
    Should Be Equal As Strings      ${Final_Confirm_Msg}        Thank you for submitting your project