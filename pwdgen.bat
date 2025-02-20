@echo off
if "%1" == "" ( set out="\n\n" ) else ( set out="%1\n" )
if "%1" == "num" ( goto :numgen )
printf %out% | pwsh -command .\passwordgen.ps1
goto :finish

:numgen
pwsh -command .\passwordgenNUM.ps1
goto :finish

:finish

echo:

