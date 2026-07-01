@echo off
setlocal EnableDelayedExpansion

for %%i in ("%CD%") do set NAME=%%~nxi

if exist "%NAME%.zip" del "%NAME%.zip"

:: 黑名单(空格分隔)
set EXCLUDE=.git .gitignore packing.bat %NAME%.zip

set FILES=

:: 文件
for %%f in (*) do (
    set SKIP=
    for %%e in (%EXCLUDE%) do (
        if /I "%%f"=="%%e" set SKIP=1
    )
    if not defined SKIP (
        set FILES=!FILES! "%%f"
    )
)

:: 文件夹
for /D %%d in (*) do (
    set SKIP=
    for %%e in (%EXCLUDE%) do (
        if /I "%%d"=="%%e" set SKIP=1
    )
    if not defined SKIP (
        set FILES=!FILES! "%%d"
    )
)

tar -a -c -f "%NAME%.zip" !FILES!

echo.
echo Done: %NAME%.zip
pause