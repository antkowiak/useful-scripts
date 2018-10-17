@ECHO OFF 
PUSHD "%~dp0" 

DIR /B %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
DIR /B %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

FOR /f %%i IN ('findstr /i . List.txt 2^>nul') DO dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 
PAUSE
