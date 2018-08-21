@echo off

set CF_PREFIX=kg-test
set SCRIPT_PATH=%~dp0
set ALL_APPS=config-service discovery-service gateway-service user-service docs-service

shift
set ARGS=%*
echo Args is: %ARGS%

IF "%ARGS%" == "" (
    echo Set apps to %ALL_APPS%
    set APPS_TO_STOP=%ALL_APPS%
) else (
    echo Set apps to %ARGS%
    set APPS_TO_STOP=%ARGS%
)

(for %%a in (%APPS_TO_STOP%) do (
    echo Starting app %%a
    %SCRIPT_PATH%\gradlew.bat :%%a:clean :%%a:build
    cf push %CF_PREFIX%-%%a -f %SCRIPT_PATH%\manifest.yml
))
