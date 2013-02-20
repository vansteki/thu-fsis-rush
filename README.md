thu-fsis-rush
=============
## THU 選課大作戰!
  我只幫你們登陸，接下來就靠各位同志了!
## Require
  "For Windows + Firefox only"
  
  you'll need:
  
    Windows7
    Mozilla Firefox >= 18.0
  
  Test on Windows7, Firefox19 beta, Ruby1.8.7
## Usage
    fsis.exe 
    >"Enter ID"
    輸入帳號
    >"Enter Password"
    輸入密碼 (輸入過程不會被看到)
    >"Rush Times?"
    輸入重試次數
## Dev info
### Require
    Ruby >= 1.8.7 
    gem install watir-webdriver
    gem istall highline
###
    ruby fsis.rb
    input:
    [ID]
    [PASS]
    [rush time]
  
### Ruby 2 exe
    gem isntall ocra
    ocra fsis.rb
    if success , then you can see a file named fsis.exe in the same folder

##Doesn't work?
*check firewall

*check firefox version

