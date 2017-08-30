@echo off
echo Start

@rem list of ignored files and folders
set "IGNORE=\.gitignore\.git\.idea\.output\CONTRIBUTING.md\README.md\packager.bat\"

if exist .output @rd /s/q .output

@rem getting current directory name
for %%* in (.) do set CURRENT_DIRECTORY=%%~nx*

@rem generating archive name based on version from a .toc file
for /f "tokens=*" %%a in (%CURRENT_DIRECTORY%.toc) do (
    set LINE=%%a
    setlocal enabledelayedexpansion
    if not "!LINE:Version=!"=="!LINE!" (
        set "ARCHIVE_NAME=%CURRENT_DIRECTORY% !LINE:## Version: =!.zip"
        goto :proceed
    )
    endlocal
)

:proceed
echo Archive name: %ARCHIVE_NAME%

@rem copying addon's files into a temporary directory
if not exist .output\%CURRENT_DIRECTORY% mkdir .output\%CURRENT_DIRECTORY%

setlocal enabledelayedexpansion
for /d %%a in (*) do (
    if /i "!IGNORE:\%%~nxa\=!" equ "%IGNORE%" (
        xcopy /v/z/e/i "%%a" ".output\%CURRENT_DIRECTORY%\%%a"
    )
)
for %%a in (*.*) do (
    if /i "!IGNORE:\%%~nxa\=!" equ "%IGNORE%" (
        xcopy /v/z "%%a" ".output\%CURRENT_DIRECTORY%"
    )
)
endlocal

@rem zipping using 7-Zip
cd .output
set ZIP_PATH="C:\Program Files\7-Zip\7z.exe"
if not exist %ZIP_PATH% (
    echo Cannot find 7-Zip application. Expected location %ZIP_PATH%
) else (
    echo Zipping...
    %ZIP_PATH% a -tzip "%ARCHIVE_NAME%" %CURRENT_DIRECTORY%
    echo Successfully zipped: .output/%ARCHIVE_NAME%
)

@rd /s/q "%CURRENT_DIRECTORY%"
