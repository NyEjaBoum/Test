@echo off
setlocal enabledelayedexpansion

REM compile.bat - compile le webapp "test" en réutilisant framework.jar dans Tomcat/lib

echo === COMPILE ET DEPLOY TEST ===

REM Configuration
set "ROOT_DIR=%~dp0"
set "APP_NAME=test"
set "TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.1"
set "TOMCAT_WEBAPPS=%TOMCAT_HOME%\webapps"
set "TOMCAT_LIB=%TOMCAT_HOME%\lib"

set "BUILD_CLASSES=%ROOT_DIR%build\classes"
set "BUILD_WAR_DIR=%ROOT_DIR%build\war\%APP_NAME%"
set "TEST_SRC_DIR=%ROOT_DIR%test"
set "OUT_WEBINF_CLASSES=%BUILD_WAR_DIR%\WEB-INF\classes"

set "FRAMEWORK_JAR=%TOMCAT_LIB%\framework.jar"

echo ROOT_DIR=%ROOT_DIR%
echo APP_NAME=%APP_NAME%
echo TOMCAT_HOME=%TOMCAT_HOME%

REM Vérifier framework.jar dans Tomcat/lib
if not exist "%FRAMEWORK_JAR%" (
    echo ERREUR: framework.jar introuvable dans Tomcat ^(%FRAMEWORK_JAR%^).
    echo Executez d'abord build.bat ou placez framework.jar dans Tomcat/lib.
    pause
    exit /b 1
)

echo Framework JAR utilise : %FRAMEWORK_JAR%
echo Compilation du projet test et deploiement vers %TOMCAT_WEBAPPS%\%APP_NAME%

REM Préparer répertoires
if exist "%BUILD_CLASSES%" rmdir /s /q "%BUILD_CLASSES%"
if exist "%BUILD_WAR_DIR%" rmdir /s /q "%BUILD_WAR_DIR%"
mkdir "%BUILD_CLASSES%"
mkdir "%OUT_WEBINF_CLASSES%"

REM Lister et compiler les sources Java du module test
if exist "%ROOT_DIR%build\test-sources.txt" del "%ROOT_DIR%build\test-sources.txt"
dir /b /s "%TEST_SRC_DIR%\*.java" > "%ROOT_DIR%build\test-sources.txt" 2>nul

REM Vérifier si des sources existent
for %%A in ("%ROOT_DIR%build\test-sources.txt") do (
    if %%~zA==0 (
        echo Aucune source test trouvee dans %TEST_SRC_DIR%
        goto :deploy
    )
)

echo Compilation des sources test...
javac -cp "%FRAMEWORK_JAR%;%TOMCAT_LIB%\*" -d "%BUILD_CLASSES%" @"%ROOT_DIR%build\test-sources.txt"

if %ERRORLEVEL% neq 0 (
    echo ERREUR: compilation des sources test a echoue
    pause
    exit /b 1
)
del "%ROOT_DIR%build\test-sources.txt"

REM Copier les .class compilées sous WEB-INF/classes
echo Copie des classes compilees...
xcopy "%BUILD_CLASSES%\*" "%OUT_WEBINF_CLASSES%\" /E /I /Y >nul

:deploy
REM Copier les ressources webapp (JSP, web.xml...) depuis test/WEB-INF
if exist "%TEST_SRC_DIR%\WEB-INF" (
    echo Copie des ressources WEB-INF...
    if not exist "%BUILD_WAR_DIR%\WEB-INF" mkdir "%BUILD_WAR_DIR%\WEB-INF"
    xcopy "%TEST_SRC_DIR%\WEB-INF\*" "%BUILD_WAR_DIR%\WEB-INF\" /E /I /Y >nul
    REM Supprimer framework.jar s'il a été copié
    if exist "%BUILD_WAR_DIR%\WEB-INF\lib\framework.jar" del "%BUILD_WAR_DIR%\WEB-INF\lib\framework.jar"
)

REM Copier autres ressources statiques (HTML, CSS, JS)
echo Copie des ressources statiques...
for %%F in ("%TEST_SRC_DIR%\*.html" "%TEST_SRC_DIR%\*.css" "%TEST_SRC_DIR%\*.js") do (
    if exist "%%F" copy "%%F" "%BUILD_WAR_DIR%\" >nul
)

REM Déployer exploded
echo Deploiement exploded dans %TOMCAT_WEBAPPS%\%APP_NAME% ...

REM Supprimer l'ancien déploiement
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%" rmdir /s /q "%TOMCAT_WEBAPPS%\%APP_NAME%"
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%.war" del "%TOMCAT_WEBAPPS%\%APP_NAME%.war"

REM Copier le nouveau déploiement
xcopy "%BUILD_WAR_DIR%\*" "%TOMCAT_WEBAPPS%\%APP_NAME%\" /E /I /Y >nul

REM Créer le dossier uploads dans le webapp déployé
if not exist "%TOMCAT_WEBAPPS%\%APP_NAME%\uploads" (
    mkdir "%TOMCAT_WEBAPPS%\%APP_NAME%\uploads"
    echo Dossier uploads cree : %TOMCAT_WEBAPPS%\%APP_NAME%\uploads
)

REM S'assurer qu'on n'a pas copié framework.jar dans l'app
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib\framework.jar" (
    del "%TOMCAT_WEBAPPS%\%APP_NAME%\WEB-INF\lib\framework.jar"
)

REM Remove Tomcat work dir to force JSP recompilation
if exist "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%" (
    rmdir /s /q "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%"
    echo Cache JSP supprime.
)

echo.
echo === DEPLOIEMENT TERMINE ===
echo Application disponible : http://localhost:8080/%APP_NAME%/
echo.
echo URLs de test :
echo   - http://localhost:8080/%APP_NAME%/etudiant/upload-form
echo   - http://localhost:8080/%APP_NAME%/etudiant/save-form
echo   - http://localhost:8080/%APP_NAME%/etudiant/api/etudiants

pause