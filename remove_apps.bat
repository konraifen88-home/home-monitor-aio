@echo off

set CF_PREFIX=kg-test
set SCRIPT_PATH=%~dp0
set ALL_APPS=docs-service user-service gateway-service discovery-service config-service

shift
set ARGS=%*

IF "%ARGS%" == "" (
    echo Set apps to %ALL_APPS%
    set APPS_TO_STOP=%ALL_APPS%
) else (
    echo Set apps to %ARGS%
    set APPS_TO_STOP=%ARGS%
)

(for %%a in (%APPS_TO_STOP%) do (
    echo Stopping app %%a
    cf stop %CF_PREFIX%-%%a
    cf delete -f %CF_PREFIX%-%%a
))
