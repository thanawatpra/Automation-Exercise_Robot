***Settings***
Library         SeleniumLibrary

***Variables***
${URL}                      https://www.automationexercise.com
${BROWSER}                  Chrome
${setEmail}                 testautomate123456789@gmail.com
${setPassword}              PassWord1234
${firstname}                test
${lastname}                 automate
${address}                  100/1
${state}                    test
${city}                     BKK
${zipcode}                  10000
${mobilenumber}             0958238756

***Keywords***
Signup Valid
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       xpath=//a[text()=" Signup / Login"]     timeout=10s
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="signup-name"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="signup-email"]     timeout=10s
    Input text      xpath=//input[@data-qa="signup-name"]       test
    Input text      xpath=//input[@data-qa="signup-email"]      ${setEmail}
    Click Element       xpath=//button[@data-qa="signup-button"]
    Wait Until Page Contains        Enter Account Information       timeout=10s
    Click Element       id=id_gender1
    Input Text      id=password         ${password}
    Click Element       id=days
    Select From List By Value       xpath=//select[@data-qa="days"]         15
    Select From List By Value       xpath=//select[@data-qa="months"]       3
    Select From List By Label       xpath=//select[@data-qa="years"]        2000
    Input Text      id=first_name       ${firstname}
    Input Text      id=last_name        ${lastname}
    Input Text      id=address1         ${address}
    Select From List By Label       xpath=//select[@data-qa="country"]        Canada
    Input Text      id=state            ${state}
    Input Text      id=city             ${city}
    Input Text      id=zipcode          ${zipcode}
    Input Text      id=mobile_number    ${mobilenumber}
    Click Element       xpath=//button[text()="Create Account"]
    Wait Until Page Contains        Congratulations! Your new account has been successfully created!       timeout=10s
    Page Should Contain             Congratulations! Your new account has been successfully created!
    Click Element       xpath=//a[text()="Continue"]
    ${username}=        Get Text        xpath=//a//b
    Should Be Equal As Strings      ${username}     ${firstname}

Signup Invalid
    [Arguments]     ${name}=     ${email}=
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       xpath=//a[text()=" Signup / Login"]     timeout=10s
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="signup-name"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="signup-email"]     timeout=10s
    IF      '${name}' != ''
        Input text      xpath=//input[@data-qa="signup-name"]       ${name}
    END
    IF     '${email}' != ''
        Input text      xpath=//input[@data-qa="signup-email"]      ${email}
    END
    Click Element       xpath=//button[@data-qa="signup-button"]
    Sleep       0.5s

Login Valid
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       xpath=//a[text()=" Signup / Login"]     timeout=10s
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-email"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-password"]     timeout=10s
    Input text      xpath=//input[@data-qa="login-email"]           ${setEmail}
    Input text      xpath=//input[@data-qa="login-password"]        ${setPassword}
    Click Element       xpath=//button[@data-qa="login-button"]

Login Invalid
    [Arguments]     ${Email}=     ${password}=
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       xpath=//a[text()=" Signup / Login"]     timeout=10s
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-email"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-password"]     timeout=10s
    IF      '${Email}' != ''
        Input text      xpath=//input[@data-qa="login-email"]           ${Email}
    END
    IF     '${password}' != ''
        Input text      xpath=//input[@data-qa="login-password"]        ${password}
    END
    Click Element       xpath=//button[@data-qa="login-button"]
    Sleep       0.5s

Login SQLInjection
    Open Browser        ${URL}              ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible       xpath=//a[text()=" Signup / Login"]     timeout=10s
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-email"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-password"]     timeout=10s
    Input Text          xpath=//input[@data-qa="login-email"]           ${setEmail}
    Input Text          xpath=//input[@data-qa="login-password"]        ' OR 1=1--
    Click Element       xpath=//button[@data-qa="login-button"]