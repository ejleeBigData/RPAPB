*** Settings ***
Library     RPA.Browser.Selenium
Library     Collections
Library     RPA.Excel.Files
Library     DateTime


*** Variables ***
@{URL}              https://news.sbs.co.kr/news/newsMain.do    https://news.kbs.co.kr/common/main.html
@{Sheet Name}       sbs    kbs
${file_name}        NewsData_.xlsx


*** Tasks ***
Extract News Text
    SBS Task
    KBS Task


*** Keywords ***
SBS Task
    Open Available Browser    ${URL}[0]    headless=${TRUE}
    Wait Until Page Contains Element    class:w_news_list
    ${text_elements}=    Get WebElements    class:w_news_list .desc
    Scroll Element Into View    class:w_news_list
    ${text_list}=    Create List
    FOR    ${element}    IN    @{text_elements}
        ${text}=    Get Text    ${element}
        Append To List    ${text_list}    ${text}
    END
    Close Browser
    @{time}=    Get Time    year month day hour min sec
    ${file_name}=    Set Variable    NewsData_${time}[0]${time}[1]${time}[2].xlsx
    Create Workbook
    ...    ${file_name}
    ...    xlsx
    ...    ${Sheet Name}[0]_${time}[0]${time}[1]${time}[2]${time}[3]${time}[4]${time}[5]
    Append Rows To Worksheet    ${text_list}
    Save Workbook    %{ROBOT_ROOT}${/}result${/}${file_name}
    Log    News text extracted and saved to ${File Name}

KBS Task
    Open Available Browser    ${URL}[1]    headless=${TRUE}
    Wait Until Page Contains Element    class:desc
    ${text_elements}=    Get WebElements    class:desc .tit
    ${text_list}=    Create List
    FOR    ${element}    IN    @{text_elements}
        ${text}=    Get Text    ${element}
        Append To List    ${text_list}    ${text}
    END
    Close Browser
    @{time}=    Get Time    year month day hour min sec
    ${file_name}=    Set Variable    NewsData_${time}[0]${time}[1]${time}[2].xlsx
    Open Workbook    %{ROBOT_ROOT}${/}result${/}${file_name}
    Create Worksheet	${Sheet Name}[1]_${time}[0]${time}[1]${time}[2]${time}[3]${time}[4]${time}[5]    
    Append Rows To Worksheet    ${text_list}
    Save Workbook    #%{ROBOT_ROOT}${/}result${/}${file_name}
    Log    News text extracted and saved to ${File Name}
