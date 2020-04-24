@echo off
Title %~nx0 by Boruwaka 2020
mode con cols=150 lines=50 & Color 9E
if _%1_==_Main_  goto :Main
:getadmin
    echo(
    echo "%~nx0" : Running Admin Shell
    set vbs=%temp%\getadmin.vbs
(
    echo Set UAC = CreateObject^("Shell.Application"^)
    echo UAC.ShellExecute "%~s0", "Main %~sdp0 %*", "", "runas", 1
)> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof
::**********************************************************************************
:Main
set "fld=%~dp0"
dir /b %fld%
echo %fld%
echo "LIST OF FOLDERS"

for /D %%X in (%fld%*) do call :setIco "%%X"

echo     Travail termine !

taskkill /im explorer.exe /f >nul & start explorer
Explorer.exe /e,/root,"%~dp0"
Timeout /T 5 /nobreak>nul & exit

:setIco
Setlocal enabledelayedexpansion
set "fld=%~1"
set "ico=%~1\icon.ico"

echo     On s'occupe de "%ico%"
If exist "%ico%" (
    echo     Le fichier existe "%ico%"
    Attrib -s "%ico%"
) else (
    Color 0C
    echo     Le fichier "icon.ico" doit se trouver dans le repertoire "%ico%"
    Color 9E
    goto :eof
)
if exist "%fld%\desktop.ini" ( attrib -h -s -a "%fld%\desktop.ini" >nul 2>&1 )

(
    echo [.ShellClassInfo]
    echo IconResource="%ico%",0
)> "%fld%\Desktop.ini"

attrib +h +s +a "%fld%\Desktop.ini"
attrib +r "%fld%"
Rem To refresh the explorer by killing and restart it

If "%ErrorLevel%" EQU "0" (
    echo     OK pour celui la
) else (
    cls & color 0C
    echo     Une erreur s'est produite lors de la lecture du programme
    Timeout /T 4 /nobreak>nul
)
