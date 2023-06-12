*** Settings ***
Library     RPA.Browser.Selenium
Library     Collections


*** Variables ***
${item}             icebox+50L
@{list_url}
...    https://browse.gmarket.co.kr/search?keyword=${item}
...    https://browse.auction.co.kr/search?keyword=icebox50l&itemno=&nickname=&frm=hometab&dom=auction&isSuggestion=No&retry=&Fwk=icebox50l&acode=SRP_SU_0100&arraycategory=&encKeyword=${item}
...    https://search.11st.co.kr/Search.tmall?kwd=${item}
@{list_price}

*** Tasks ***
Market_01
    Open_web
    Go_gmarket
    Go_auction
    Go_11
    Min_price


*** Keywords ***
Open_web
    Open Available Browser    headless=${FALSE}

Go_gmarket
    Go To    ${list_url}[0]
    ${text_price1}=    Get Text    alias:Boxcomponentnthchild1boxpricesellertextvalue
    Append To List    ${list_price}    ${text_price1}

Go_auction
    Go To    ${list_url}[1]
    ${text_price2}=    Get Text
    ...    //*[@id="section--inner_content_body_container"]/div[2]/div[1]/div/div[2]/div[2]/div[1]/div[2]/span/strong
    Append To List    ${list_price}    ${text_price2}

Go_11
    Go To    ${list_url}[2]
    ${text_price3}=    Get Text
    ...    //*[@id="layBodyWrap"]/div/div/div[3]/div/section[1]/ul/li[1]/div/div[2]/div/div[3]/dl/div/dd/span[1]
    Append To List    ${list_price}    ${text_price3}

Min_price
    Log    ${list_price}
     
