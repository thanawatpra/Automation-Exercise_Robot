***Settings***
Library     SeleniumLibrary
Library     String
Resource        ../loginAE.robot

***Variables***
${URL}          https://www.automationexercise.com
${BROWSER}      Chrome
${Buy}          Register / Login account to proceed on checkout.

***Keywords***
Add Order
    Wait Until Element Is Visible       xpath=//a[@data-product-id="1"]     timeout=10s
    Click Element       xpath=//a[@data-product-id="1"]
    Wait Until Element Is Visible       xpath=//button[text()="Continue Shopping"]      timeout=10s
    Click Element       xpath=//button[text()="Continue Shopping"]
    Wait Until Element Is Visible       xpath=//a[@data-product-id="2"]     timeout=10s
    Click Element       xpath=//a[@data-product-id="2"]
    Wait Until Element Is Visible       xpath=//button[text()="Continue Shopping"]      timeout=10s
    Click Element       xpath=//button[text()="Continue Shopping"]
    Execute JavaScript      window.scrollTo(0, 0)
    Click Element       xpath=//ul[@class="nav navbar-nav"]//a[normalize-space(.)="Cart"]
    Click Element       xpath=//a[text()="Proceed To Checkout"]

Check Total_Price
    ${all_prices}=    Get WebElements    xpath=//tr[starts-with(@id,"product-")]//p[@class="cart_total_price"]
    ${sum}=    Set Variable    0
    FOR    ${price_element}    IN    @{all_prices}
        ${text}=    Get Text    ${price_element}
        ${text}=    Replace String    ${text}    Rs.     ${EMPTY}
        ${text}=    Strip String    ${text}
        ${value}=    Convert To Integer    ${text}
        ${sum}=    Evaluate    ${sum} + ${value}
    END
    [Return]        ${sum}

***Test Cases***
TC_Products_001 : Verify that you have added items to your cart and placed an order while you are not logged in.
    Open Browser        ${URL}      ${BROWSER}
    Maximize Browser Window
    Add Order
    Page Should Contain     ${Buy}
    Element Should Contain      xpath=//button[@data-dismiss="modal"]      Continue On Cart
    Click Element       xpath=//button[@data-dismiss="modal"]

TC_Products_002 : Check the order from TC_Products_001 after successfully logging in.
    Click Element       xpath=//a[text()=" Signup / Login"]
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-email"]     timeout=10s
    Wait Until Element Is Visible       xpath=//input[@data-qa="login-password"]     timeout=10s
    Input text      xpath=//input[@data-qa="login-email"]           ${setEmail}
    Input text      xpath=//input[@data-qa="login-password"]        ${setPassword}
    Click Element       xpath=//button[@data-qa="login-button"]
    Click Element       xpath=//ul[@class="nav navbar-nav"]//a[normalize-space(.)="Cart"]
    ${TOTAL_PRICE}=     Check Total_Price
    Click Element       xpath=//a[text()="Proceed To Checkout"]
    ${total}=           Check Total_Price
    Should Be Equal As Integers    ${total}     ${TOTAL_PRICE}

TC_Products_003 : Verify your order without filling out the Payment
    Click Element       xpath=//a[text()="Place Order"]
    Click Element       id=submit
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="name-on-card"]').validity.valueMissing
    Should Be True      ${validity}

TC_Products_004 : Check the product order by filling out the payment form incompletely.
    Input Text          xpath=//input[@name="name_on_card" and @data-qa="name-on-card"]     test1234
    Click Element       id=submit
    ${validity}=        Execute Javascript      return document.querySelector('input[data-qa="card-number"]').validity.valueMissing
    Should Be True      ${validity}

TC_Products_005 : Verify your purchase by filling out the payment form correctly and completely.
    Press Keys          xpath=//input[@name="name_on_card" and @data-qa="name-on-card"]     CTRL+A      DELETE
    Input Text          xpath=//input[@name="name_on_card" and @data-qa="name-on-card"]     test
    Input Text          xpath=//input[@name="card_number" and @data-qa="card-number"]       1-234-567-89-0
    Input Text          xpath=//input[@name="cvc" and @data-qa="cvc"]                       310
    Input Text          xpath=//input[@name="expiry_month" and @data-qa="expiry-month"]     12
    Input Text          xpath=//input[@name="expiry_year" and @data-qa="expiry-year"]       2022
    Click Element       id=submit