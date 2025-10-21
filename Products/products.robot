***Settings***
Library     SeleniumLibrary
Library     String
Resource        ../loginAE.robot

***Variables***
${URL}              https://www.automationexercise.com
${BROWSER}          Chrome
${Buy}              Register / Login account to proceed on checkout.
${Name_on_Card}     test
${Card_Number}      1-234-567-89-0
${CVC}              310
${Expiration_1}     12
${Expiration_2}     2022

***Keywords***
Add Order
    Add Products        1
    Add Products        2
    Execute JavaScript      window.scrollTo(0, 0)
    Click Element       xpath=//ul[@class="nav navbar-nav"]//a[normalize-space(.)="Cart"]
    Click Element       xpath=//a[text()="Proceed To Checkout"]

Add Products
    [Arguments]     ${id_Product}
    Wait Until Element Is Visible       xpath=//a[@data-product-id="${id_Product}"]     timeout=10s
    Click Element       xpath=//a[@data-product-id="${id_Product}"]
    Wait Until Element Is Visible       xpath=//button[text()="Continue Shopping"]      timeout=10s
    Click Element       xpath=//button[text()="Continue Shopping"]

Delete Products
    [Arguments]     ${id_Product}       ${name_Products}
    Click Element       xpath=//a[@class="cart_quantity_delete" and @data-product-id="${id_Product}"]
    Wait Until Page Does Not Contain        ${name_Products}
    Page Should Not Contain     ${name_Products}

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

Check The Price
    Click Element       xpath=//ul[@class="nav navbar-nav"]//a[normalize-space(.)="Cart"]
    ${TOTAL_PRICE}=     Check Total_Price
    Click Element       xpath=//a[text()="Proceed To Checkout"]
    ${total}=           Check Total_Price
    Should Be Equal As Integers    ${total}     ${TOTAL_PRICE}

Input Card_Number_Success
    Input Text          xpath=//input[@name="name_on_card" and @data-qa="name-on-card"]     ${Name_on_Card}
    Input Text          xpath=//input[@name="card_number" and @data-qa="card-number"]       ${Card_Number}
    Input Text          xpath=//input[@name="cvc" and @data-qa="cvc"]                       ${CVC}
    Input Text          xpath=//input[@name="expiry_month" and @data-qa="expiry-month"]     ${Expiration_1}
    Input Text          xpath=//input[@name="expiry_year" and @data-qa="expiry-year"]       ${Expiration_2}
    Click Element       id=submit

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
    Check The Price

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
    Input Card_Number_Success

TC_Products_006 : Check order downloads
    Click Element       xpath=//a[text()="Download Invoice"]

TC_Products_007 : Check product details
    Click Element       xpath=//a[@data-qa="continue-button"]
    Execute JavaScript      window.scrollTo(0, 1000)
    Click Element       xpath=//p[normalize-space(.)='Winter Top']/ancestor::div[@class='product-image-wrapper']//a[contains(text(),'View Product')]
    Page Should Contain     Winter Top

TC_Products_008 : Check the addition of more than 1 item
    Click Element       xpath=//button[@class="btn btn-default cart"]
    Wait Until Element Is Visible       xpath=//button[text()="Continue Shopping"]      timeout=10s
    Click Element       xpath=//button[text()="Continue Shopping"]
    Click Element       xpath=//a[@href="/products"]
    Execute JavaScript      window.scrollTo(0, 2000)
    Add Products        14

TC_Products_009 : Check the addition of more than one item
    Execute JavaScript      window.scrollTo(0, 1000)
    Click Element       xpath=//a[@href="/product_details/43"]
    Press Keys          id=quantity     CTRL+A      DELETE
    Input Text          id=quantity     3
    Click Element       xpath=//button[@class="btn btn-default cart"]
    Wait Until Element Is Visible       xpath=//button[text()="Continue Shopping"]      timeout=10s
    Click Element       xpath=//button[text()="Continue Shopping"]

TC_Products_010 : Check product deletion
    Click Element       xpath=//ul[@class="nav navbar-nav"]//a[normalize-space(.)="Cart"]
    Delete Products     5       Winter Top
    Delete Products     14     Fancy Green Top
    Delete Products     43     GRAPHIC DESIGN MEN T SHIRT - BLUE

TC_Products_011 : Check product search by Category
    Click Element       xpath=//a[@href="/products"]
    Click Element       xpath=//a[normalize-space(.)='Kids']
    Wait Until Element Is Visible       xpath=//a[normalize-space(.)='Tops & Shirts']       timeout=10s
    Click Element       xpath=//a[normalize-space(.)='Tops & Shirts']
    Element Should Contain      xpath=//li[@class="active"]     Kids > Tops & Shirts

TC_Products_012 : Check the addition of product items from Category search
    Execute JavaScript      window.scrollTo(500, 1500)
    Add Products        14
    Check The Price
    Click Element       xpath=//a[text()="Place Order"]
    Input Card_Number_Success
    Click Element       xpath=//a[@data-qa="continue-button"]

TC_Products_013 : Check product searches from Brands
    Click Element       xpath=//a[text()="Madame"]
    
TC_Products_014 : Check the addition of products from Brands search
    Add Products        38
    Check The Price
    Click Element       xpath=//a[text()="Place Order"]
    Input Card_Number_Success
    Click Element       xpath=//a[@data-qa="continue-button"]