*** Settings ***
Library     RPA.Browser.Selenium
Library     Collections


*** Variables ***
${item}             icebox+50L
@{list_url}
...    https://browse.gmarket.co.kr/search?keyword=${item}
...    http://browse.auction.co.kr/search?keyword=icebox+50L&itemno=&nickname=&frm=hometab&dom=auction&isSuggestion=No&retry=&Fwk=icebox+50L&acode=SRP_SU_0100&arraycategory=&encKeyword=${item}
...    http://search.11st.co.kr/MW/search?searchKeyword=icebox%252050L&decSearchKeyword=icebox%252050L#_filterKey=1686408835504
@{list_xpath}
...    css=.box__price-seller strong
...    //*[@id="section--inner_content_body_container"]/div[2]/div[1]/div[1]/div[2]/div[2]/div[1]/div[2]/span[1]/strong
...    //*[@id="cts"]/div/div[4]/ul/li[1]/div/a/div[2]/dl[2]/dd/strong
@{list_price}
${price}


*** Tasks ***
Get Market Prices
    Open Browser
    Step0 Market
    Step1 Market
    Step2 Market
    Get Prices
    Close Browser


*** Keywords ***
Open Browser
    Open Available Browser

Step0 Market
    Go To    ${list_url}[0]
    ${price}=    Get Text    ${list_xpath}[0]
    Append To List    ${list_price}    ${price}

Step1 Market
    Go To    ${list_url}[1]
    ${price}=    Get Text    ${list_xpath}[1]
    Append To List    ${list_price}    ${price}

Step2 Market
    Go To    ${list_url}[2]
    ${price}=    Get Text    ${list_xpath}[2]
    Append To List    ${list_price}    ${price}

Get Prices
    Sort List    ${list_price}
    Log    ${list_price}
    Log    ${list_price}[0]

Close Browser
    Close All Browsers
