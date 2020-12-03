*** Settings ***
Library         ExcelLibrary
Library         Selenium2Library
Library         XvfbRobot
Force Tags      WebDemo

*** Variables ***
${TMP_PATH}                 /tmp

*** Test Cases ***
WebDemo test
    Open Excel	/suites/webdemo.xls
    ${Sheet}=      Get Sheet Values   data   False
    Log            ${Sheet}
    ${rowcount}    Get Row Count      data
    Log            ${rowcount}
    ${keywords}=   Get Row Values   data   0   False
    Log            ${keywords}

    Start Virtual Display    1440    900
    Open Chrome Browser
    GoTo    file:///suites/keres.html

    FOR    ${row}    IN RANGE    1    ${rowcount}

        ${testdata}=      Get Row Values   data   ${row}   True
        Log               ${testdata}
        Log               ${testdata}[0][1]
        Log               ${testdata}[1][1]

        Run Keyword   DEMO test   ${testdata}[0][1]   ${testdata}[1][1]

    END


*** Keywords ***
Open Chrome Browser
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

DEMO test
    [Arguments]    ${pattern}    ${db}

    KERES    ${pattern}

    Page Should Contain   ${db}

KERES
    [Arguments]    ${pattern}

    Input Text      id:pattern     ${pattern}


