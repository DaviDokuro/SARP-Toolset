@echo off
set APPVERSION=1.2
set APPTITLE=Yamaha AICA ADPCM Stream to RIFF WAVE Mass Converter Version %APPVERSION%
title %APPTITLE%
echo %APPTITLE% 
echo ===============================================================================

set STR2WAV=..\str2wav
set INPUT_DIR=.\input
set OUTPUT_DIR=.\output

:start
set FILESFOUND=0

for /d %%a in (%INPUT_DIR%\*) do (
	md  "%OUTPUT_DIR%\%%~na"
	for %%b in ("%%a\*.str") do (
		set FILESFOUND=1
		echo.
		call %STR2WAV% "%%b" "%OUTPUT_DIR%\%%~na\%%~nb.wav"
	)
)
if "%FILESFOUND%"=="1" goto done
goto no_input

:no_input
echo.
echo Please copy your .STR files in the "%INPUT_DIR%" directory!
goto end

:done
echo.
echo Batch conversion done!

:end
pause
title %ComSpec%
