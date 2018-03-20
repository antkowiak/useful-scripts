@ECHO OFF
REM
REM Fix ownership and permissions of a file that is owned by
REM the "TrustedInstaller" user and prevents the Administrator accounts
REM from removing or renaming the file.
REM
REM This was useful because I wanted to replace the
REM C:\windows\system32\calc.exe
REM file to no longer be a stub to prompt me to download Microsoft's
REM under-featured calculator from the Windows Store, and to use
REM the CalcPlus.exe (Calculator Plus) app instead.
REM
REM This must be from an administrator CMD prompt.
REM

CD C:\windows\system32\
takeown /F calc.exe
icacls calc.exe /grant administrators:F
copy calc.exe calc.exe_bak
del calc.exe
copy calcplus.exe calc.exe


