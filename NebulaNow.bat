@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul
mode con: cols=110
title Nebula.Now
set "N1=FRISK"
set "C1=Combat"
set "I1=5652075283"
set "P1=require(5652075283).FRISK(""
set "S1=")"
set "H1=1"
set "N2=Betty"
set "C2=Combat"
set "I2=5150273023"
set "P2=require(5150273023).betty(""
set "S2=")"
set "H2=1"
set "N3=Underman"
set "C3=Combat"
set "I3=5628525967"
set "P3=require(5628525967).underman(""
set "S3=")"
set "H3=1"
set "N4=Ink Sans"
set "C4=Combat"
set "I4=5420931037"
set "P4=require(5420931037).Ink(""
set "S4=")"
set "H4=1"
set "N5=Underfell"
set "C5=Combat"
set "I5=5157795705"
set "P5=require(5157795705).fell(""
set "S5=")"
set "H5=1"
set "N6=Vbucks GUI"
set "C6=GUIs"
set "I6=5520080089"
set "P6=require(5520080089).vbucks(""
set "S6=")"
set "H6=1"
set "N7=OWO GUI"
set "C7=GUIs"
set "I7=5457838278"
set "P7=require(5457838278).owo(""
set "S7=")"
set "H7=1"
set "N8=Fish Chat"
set "C8=Nebula Trusted GUIs"
set "I8=77886688623397"
set "P8=require(77886688623397)(true, true, false)"
set "S8="
set "H8=0"
set "COUNT=8"
set "SIG=1963853489"
setlocal EnableDelayedExpansion

set "K0=All"
set "K1=Combat"
set "K2=Animations"
set "K3=GUIs"
set "K4=Nebula Trusted GUIs"
set "K5=Saved"
set "TN0=Nebula Dark"
set "TC0=0F"
set "TN1=Midnight"
set "TC1=1F"
set "TN2=Crimson"
set "TC2=0C"
set "TN3=Emerald"
set "TC3=0A"
set "TN4=Light"
set "TC4=F0"
set "TN5=Violet"
set "TC5=0D"

set "U=YourUsername"
set "SAVED=,"
set "TH=0"
set "CI=0"
set "Q="
set "MSG="
set "SHOWN=0"
set "CFG=%APPDATA%\NebulaNow\settings.cmd"
set "TMPF=%TEMP%\nebulanow_copy.txt"
if exist "!CFG!" call "!CFG!"
if not "!SAVEDSIG!"=="!SIG!" set "SAVED=,"
call :theme

:menu
cls
for %%c in (!CI!) do set "CAT=!K%%c!"
for %%t in (!TH!) do set "TNAME=!TN%%t!"
echo.
echo   NEBULA.NOW   Category: !CAT!   User: !U!   Search: !Q!   Theme: !TNAME!
echo   ------------------------------------------------------------------------------
echo.
set "SHOWN=0"
for /L %%i in (1,1,%COUNT%) do (
  call :match %%i
  if "!OKM!"=="1" (
    set /a SHOWN+=1
    set "M!SHOWN!=%%i"
    call :build %%i
    set "STAR= "
    if not "!SAVED:,%%i,=!"=="!SAVED!" set "STAR=*"
    echo   [!SHOWN!] !STAR! !N%%i!
    echo         !OUT!
    echo.
  )
)
if "!SHOWN!"=="0" echo   Nothing here yet.
echo   ------------------------------------------------------------------------------
echo   [number] copy   [A] copy all   [S] star   [F] search   [C] category   [U] username   [T] theme   [X] exit
if defined MSG echo   !MSG!
set "MSG="
set "IN="
set /p "IN=  > "
if not defined IN goto menu
set "IN=!IN:"=!"
if not defined IN goto menu
set "T=!IN!"
for %%d in (0 1 2 3 4 5 6 7 8 9) do set "T=!T:%%d=!"
if not defined T goto docopy
if /i "!IN!"=="a" goto copyall
if /i "!IN!"=="s" goto dostar
if /i "!IN!"=="f" goto dosearch
if /i "!IN!"=="c" goto docat
if /i "!IN!"=="u" goto douser
if /i "!IN!"=="t" goto dotheme
if /i "!IN!"=="x" goto quit
goto menu

:docopy
set "NUMIN=!IN!"
call :resolve
if not defined ID (
  set "MSG=That number is not in the list."
  goto menu
)
call :build !ID!
>"!TMPF!" echo(!OUT!
clip < "!TMPF!"
for %%k in (!ID!) do set "MSG=Copied: !N%%k!"
goto menu

:copyall
if "!SHOWN!"=="0" goto menu
if exist "!TMPF!" del "!TMPF!" >nul 2>&1
for /L %%n in (1,1,!SHOWN!) do (
  set "ID=!M%%n!"
  call :build !ID!
  >>"!TMPF!" echo(!OUT!
)
clip < "!TMPF!"
set "MSG=Copied !SHOWN! script(s)."
goto menu

:dostar
call :askid
if not defined ID goto menu
for %%k in (!ID!) do (
  if "!SAVED:,%%k,=!"=="!SAVED!" (
    set "SAVED=!SAVED!%%k,"
  ) else (
    set "SAVED=!SAVED:,%%k,=,!"
  )
)
call :save
goto menu

:dosearch
set "NEWQ="
set /p "NEWQ=  Search (empty to clear): "
if not defined NEWQ (
  set "Q="
  goto menu
)
set "T=!NEWQ!"
for %%c in (a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 _ . -) do set "T=!T:%%c=!"
set "T=!T: =!"
if defined T (
  set "MSG=Search can only use letters, numbers, spaces, _ . -"
  goto menu
)
set "Q=!NEWQ!"
goto menu

:docat
set /a CI=(CI+1)%%6
call :save
goto menu

:douser
set "NEWU="
set /p "NEWU=  Username (letters, numbers, _): "
if not defined NEWU goto menu
set "T=!NEWU!"
for %%c in (a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 _) do set "T=!T:%%c=!"
if defined T (
  set "MSG=Usernames can only use letters, numbers and _"
  goto menu
)
set "U=!NEWU!"
call :save
goto menu

:dotheme
set /a TH=(TH+1)%%6
call :theme
call :save
goto menu

:quit
call :save
exit /b

:theme
for %%t in (!TH!) do color !TC%%t!
exit /b

:save
if not exist "%APPDATA%\NebulaNow" mkdir "%APPDATA%\NebulaNow" >nul 2>&1
(
  echo set "U=!U!"
  echo set "SAVED=!SAVED!"
  echo set "TH=!TH!"
  echo set "CI=!CI!"
  echo set "SAVEDSIG=!SIG!"
) > "!CFG!" 2>nul
exit /b

:build
set "OUT=!P%1!"
if "!H%1!"=="1" set "OUT=!OUT!!U!!S%1!"
exit /b

:match
set "OKM=1"
if /i "!CAT!"=="Saved" (
  if "!SAVED:,%1,=!"=="!SAVED!" set "OKM=0"
)
if /i not "!CAT!"=="Saved" if /i not "!CAT!"=="All" if /i not "!C%1!"=="!CAT!" set "OKM=0"
if defined Q if "!OKM!"=="1" (
  set "HAY=!N%1! !C%1! !I%1!"
  set "REST=!HAY:%Q%=!"
  if "!REST!"=="!HAY!" set "OKM=0"
)
exit /b

:askid
set "NUMIN="
set /p "NUMIN=  Number: "
call :resolve
exit /b

:resolve
set "ID="
if not defined NUMIN exit /b
set "T=!NUMIN!"
for %%d in (0 1 2 3 4 5 6 7 8 9) do set "T=!T:%%d=!"
if defined T exit /b
if not "!NUMIN:~4!"=="" exit /b
for /f "tokens=* delims=0" %%z in ("!NUMIN!") do set "NUMIN=%%z"
set /a NUMK=!NUMIN! 2>nul
if !NUMK! lss 1 exit /b
if !NUMK! gtr !SHOWN! exit /b
for %%k in (!NUMK!) do set "ID=!M%%k!"
exit /b
