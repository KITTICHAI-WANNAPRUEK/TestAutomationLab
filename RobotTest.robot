*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${EDGE_BROWSER_PATH}    C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe
${EDGE_DRIVER_PATH}     C:/Users/Dom/EdgeforTesting/msedgedriver.exe
${BROWSER}		    Edge
${TEST_URL}                 http://localhost:7272/Registration.html

${FRIST_NAME}		    Somyod
${LAST_NAME}		    Sodsai
${ORGANIZATION}		    CS KKU
${EMAIL}		    somyod@kkumail.com
${PHONE}		    091-001-1234

*** Keywords ***
OpenEdge
    ${options}    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys
    ${options.binary_location}    Set Variable    ${EDGE_BROWSER_PATH}
    ${service}    Evaluate    sys.modules["selenium.webdriver.edge.service"].Service(executable_path=r"""${EDGE_DRIVER_PATH}""")
    Create Webdriver    Edge    options=${options}    service=${service}

*** Test Cases ***
Register Success:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Title Should Be    Success
    # Page Should Contain    Success
    Close Browser
Register without Organization:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=email            ${EMAIL}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us
    Page Should Contain    We will send a confirmation to your email soon
    Close Browser
Register without FirstName:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Page Should Contain    Workshop Registration
    Close Browser
Register without LastName:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your last name!!
    Close Browser
Register without FirstName And LastName:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your name!!
    Close Browser
Register without Email:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=phone            ${PHONE}
    Click Button   Register
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your email!!
    Close Browser
Register without PhoneNumber:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Click Button   Register
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter your phone number!!
    Close Browser
Register with Invalid PhoneNumber:
    OpenEdge
    Go To    ${TEST_URL}
    Page Should Contain    Workshop Registration
    Input Text    id=firstname        ${FRIST_NAME}
    Input Text    id=lastname         ${LAST_NAME}
    Input Text    id=organization     ${ORGANIZATION}
    Input Text    id=email            ${EMAIL}
    Input Text    name=phone          1234
    Click Button   Register
    Page Should Contain    Workshop Registration
    Page Should Contain    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)
    Close Browser
