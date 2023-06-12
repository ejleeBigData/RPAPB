*** Settings ***
Library           String
Library           RPA.Windows

Task Teardown     Close Window     name:계산기

*** Tasks ***
Run Example
    Calculate using app ids

*** Keywords ***
Open the Calculator
    Windows Search    Calculator

Add two numbers using app ids
    [Arguments]    ${first}    ${second}
    Click    id:clearEntryButton
    Click    id:num${first}Button
    Click    id:plusButton
    Click    id:num${second}Button
    Click    id:equalButton

Log results
    ${result}=    Get Attribute    id:CalculatorResults    Name
    Log    ${result}
    Screenshot    계산기   id-based-result.png

Calculate using app ids
    Open the Calculator
    Add two numbers using app ids    8    7
    Log results

