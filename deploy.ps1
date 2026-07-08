# Automated deployment script to Tomcat
$TomcatWebapps = "C:\apache-tomcat-11.0.21-windows-x64\apache-tomcat-11.0.21\webapps"
$WarName = "discoverkundasang.war"

Write-Host "===================================================" -ForegroundColor Green
Write-Host "  AUTOMATED TOMCAT DEPLOYMENT - EXPLORE KUNDASANG" -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green
Write-Host ""

# 1. Clean old deployment
Write-Host "1. Cleaning up old deployment in Tomcat..." -ForegroundColor Yellow
if (Test-Path "$TomcatWebapps\$WarName") {
    Remove-Item -Path "$TomcatWebapps\$WarName" -Force
    Write-Host "   Removed old WAR file."
}
if (Test-Path "$TomcatWebapps\discoverkundasang") {
    Remove-Item -Path "$TomcatWebapps\discoverkundasang" -Recurse -Force
    Write-Host "   Removed expanded directory."
}

# 2. Package with Maven
Write-Host "`n2. Packaging project with Maven..." -ForegroundColor Yellow
mvn clean package
if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[ERROR] Maven build failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# 3. Copy WAR file
Write-Host "`n3. Copying WAR file to Tomcat webapps..." -ForegroundColor Yellow
if (Test-Path "target\$WarName") {
    Copy-Item -Path "target\$WarName" -Destination "$TomcatWebapps" -Force
    Write-Host "`n[SUCCESS] Deployment completed successfully!" -ForegroundColor Green
    Write-Host "Access the app at: http://localhost:8080/discoverkundasang/" -ForegroundColor Cyan
} else {
    Write-Host "`n[ERROR] Generated WAR file target\$WarName not found!" -ForegroundColor Red
}
Write-Host ""
