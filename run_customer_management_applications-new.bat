@echo off

REM NPX will fail for users with spaces in their name, so we set the cache to the current folder
set npm_config_cache=%cd%
set version=0.0.1-SNAPSHOT.jar
set mvn=mvn clean install -DskipTests
set npm=npm start
set rootPath=C:\Outils\LakesideMutual
set agent=agent\nudge-4.0.3.jar
set logCondition=if exist agent\log rmdir /s /q agent\log fi
set CC=customer-core
set CMB=customer-management-backend
set CMF=customer-management-frontend
set CSSB=customer-self-service-backend
set CSSF=customer-self-service-frontend
set PMB=policy-management-backend
set PMF=policy-management-frontend
set SBA=spring-boot-admin

call npx recursive-install

REM All frontend projects installed successfully

IF %errorlevel% NEQ 0 (
  echo Aborting script, error %errorlevel%
  exit /b %errorlevel%
)

call npx concurrently ^
  --kill-others ^
  --names "%CC%,%CMB%,%CMF%,%CSSB%,%CSSF%,%PMB%,%PMF%,%SBA%" ^
  --prefix-colors "bgRed.bold,bgYellow.bold,bgBlue.bold,bgGreen.bold,bgGrey.bold,bgPink.bold,bgDarkgrey.bold,bgWhite.bold" ^
  "cd %CC% && java -javaagent:%rootPath%\%CC%\%agent% -jar target/%CC%-%version%" ^
  "cd %CMB% && java -javaagent:%rootPath%\%CMB%\%agent% -jar target/%CMB%-%version%" ^
  "cd %CMF% && %npm%" ^
  "cd %CSSB% && java -javaagent:%rootPath%\%CSSB%\%agent% -jar target/%CSSB%-%version%" ^
  "cd %CSSF% && %npm%" ^
  "cd %PMB% && java -javaagent:%rootPath%\%PMB%\%agent% -jar target/%PMB%-%version%" ^
  "cd %PMF% && %npm%" ^
  "cd %SBA% && java -javaagent:%rootPath%\%SBA%\%agent% -jar target/%SBA%-%version%"

IF %errorlevel% NEQ 0 ( 
  echo Aborting script, error %errorlevel%
  exit /b %errorlevel% 
)