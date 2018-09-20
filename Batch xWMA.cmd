@echo off
set APPVERSION=1.0
set APPTITLE=XWMA Batch Encode %APPVERSION%
title %APPTITLE%
echo %APPTITLE% 
echo ===============================================================================

set XWMAENCODE=.\xwmaencode
set INPUT_DIR=.\input
set OUTPUT_DIR=.\output

set DCNAME20="%OUTPUT_DIR%\dcname20"
set DCNAME48="%OUTPUT_DIR%\dcname48"

md  "%DCNAME20%"
md  "%DCNAME48%"

:start
set FILESFOUND=0
for /d %%a in (%INPUT_DIR%\*) do (
	md  "%DCNAME20%\%%~na"
	md  "%DCNAME48%\%%~na"
	for %%b in ("%%a\*.wav") do (
		set FILESFOUND=1
		echo.
		call %XWMAENCODE% -b 20000 "%%b" "%DCNAME20%\%%~na\%%~nb.xma"
		call %XWMAENCODE% -b 48000 "%%b" "%DCNAME48%\%%~na\%%~nb.xma"
	)
)
if "%FILESFOUND%"=="1" goto done
goto no_input

:no_input
echo.
echo You forgot to put .WAV files in "%INPUT_DIR%"!
goto end

:done
echo.
echo Converted!

:end
pause
title %ComSpec%
