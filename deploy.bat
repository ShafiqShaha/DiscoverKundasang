@echo off
title Deploy to Tomcat
echo ===================================================
echo   AUTOMATED TOMCAT DEPLOYMENT - EXPLORE KUNDASANG
echo ===================================================
echo.

set TOMCAT_WEBAPPS=C:\apache-tomcat-11.0.21-windows-x64\apache-tomcat-11.0.21\webapps
set WAR_NAME=discoverkundasang.war

echo 1. Cleaning up old deployment in Tomcat...
if exist "%TOMCAT_WEBAPPS%\%WAR_NAME%" (
    echo    Removing old WAR file...
    del /f /q "%TOMCAT_WEBAPPS%\%WAR_NAME%"
)
if exist "%TOMCAT_WEBAPPS%\discoverkundasang" (
    echo    Removing expanded directory...
    rmdir /s /q "%TOMCAT_WEBAPPS%\discoverkundasang"
)
echo.

echo 2. Packaging project with Maven...
call mvn clean package
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Maven build failed! Please check your code.
    pause
    exit /b %ERRORLEVEL%
)
echo.

echo 3. Copying new WAR file to Tomcat webapps...
if exist "target\%WAR_NAME%" (
    copy "target\%WAR_NAME%" "%TOMCAT_WEBAPPS%\"
    echo.
    echo [SUCCESS] Deployment completed successfully!
    echo Access the app at: http://localhost:8080/discoverkundasang/
) else (
    echo [ERROR] Generated WAR file target\%WAR_NAME% not found!
)
echo.
pause
