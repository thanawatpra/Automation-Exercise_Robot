***Settings***
Library         SeleniumLibrary
Resource        ../loginAE.robot

***Variables***
${vali_login_incorrect}     Your email or password is incorrect!
${vali_duplicate_mail}      Email Address already exist!

***Test Cases***
TC_Login_001 : Check your membership application if you have not filled out the application details.
    Signup Invalid
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="signup-name"]').validity.valueMissing
	Should Be True      ${validity}
    Capture Page Screenshot     TC_Login_001.png
    Close Browser

TC_Login_002 : Verify your membership application if some details have been filled in.
    Signup Invalid      ${EMPTY}        emailtestauto@gmail.com
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="signup-name"]').validity.valueMissing
	Should Be True      ${validity}
    Capture Page Screenshot     TC_Login_002.png
    Close Browser

TC_Login_003 : Check your membership application if the application details are incorrect.
    Signup Invalid      test        gmail
    ${invalid}=         Execute Javascript      return document.querySelector('input[data-qa="signup-email"]').validity.typeMismatch
	Should Be True      ${invalid}
    Capture Page Screenshot     TC_Login_003.png
    Close Browser

TC_Login_004 : Check your subscription if you have entered a duplicate email address.
    Signup Invalid      test        abc@gmail.com
    Page Should Contain       ${vali_duplicate_mail}
    Capture Page Screenshot     TC_Login_004.png
    Close Browser

TC_Login_005 : Verify your membership application if all details are filled in correctly and completely.
    Signup Valid
    Capture Page Screenshot     TC_Login_005.png
    Close Browser

TC_Login_006 : Check login if Username and Password are not entered.
    Login Invalid       ${EMPTY}        ${EMPTY}
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="login-email"]').validity.valueMissing
	Should Be True      ${validity}
    Capture Page Screenshot     TC_Login_006.png
    Close Browser

TC_Login_007 : Check login if partial information is entered
    Login Invalid       testautomatescript123456@gmail.com       ${EMPTY}
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="login-password"]').validity.valueMissing
	Should Be True      ${validity}
    Capture Page Screenshot     TC_Login_007.png
    Close Browser

TC_Login_008 : Check login information if it is incorrect.
    Login Invalid       abc@gmail.com       12345678
    Page Should Contain     ${vali_login_incorrect}
    Capture Page Screenshot     TC_Login_008.png
    Close Browser

TC_Login_009 : Check login for SQL Injection
    Login SQLInjection
    Sleep       1s
    Capture Page Screenshot     TC_Login_009.png
    Close Browser

TC_Login_010 : Verify login if the phone number or email address and password are correct.
    Login Valid
    Sleep       0.5s
    Capture Page Screenshot     TC_Login_010.png
    Close Browser

TC_Login_011 : Check logout
    Login Valid
    Click Element       xpath=//a[text()=" Logout"]
    Wait Until Element Is Not Visible       xpath=//a[text()=" Logout"]     timeout=10s
    Capture Page Screenshot     TC_Login_011.png
    Close Browser
