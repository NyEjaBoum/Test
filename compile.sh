#!/usr/bin/env bash
set -euo pipefail

# compile.sh - compile le webapp "test" en réutilisant framework.jar dans Tomcat/lib
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"    # <-- IMPORTANT : dossier 'fw'
APP_NAME="${APP_NAME:-test}"
TOMCAT_HOME="${TOMCAT_HOME:-/opt/tomcat10}"
TOMCAT_WEBAPPS="${TOMCAT_WEBAPPS:-$TOMCAT_HOME/webapps}"

BUILD_CLASSES="$ROOT_DIR/build/classes"
BUILD_WAR_DIR="$ROOT_DIR/build/war/$APP_NAME"
TEST_SRC_DIR="$ROOT_DIR/test"
OUT_WEBINF_CLASSES="$BUILD_WAR_DIR/WEB-INF/classes"

# Vérifier framework.jar dans Tomcat/lib
FRAMEWORK_JAR="$TOMCAT_HOME/lib/framework.jar"
if [ ! -f "$FRAMEWORK_JAR" ]; then
  echo "ERREUR: framework.jar introuvable dans Tomcat ($FRAMEWORK_JAR). Exportez TOMCAT_HOME ou placez framework.jar dans Tomcat/lib."
  exit 1
fi

echo "Framework JAR utilisé : $FRAMEWORK_JAR"
echo "Compilation du projet test et déploiement vers $TOMCAT_WEBAPPS/$APP_NAME (sans framework.jar dans WEB-INF/lib)."

# Préparer répertoires
rm -rf "$BUILD_CLASSES" "$BUILD_WAR_DIR"
mkdir -p "$BUILD_CLASSES" "$OUT_WEBINF_CLASSES"

# Lister et compiler les sources Java du module test
rm -f build/test-sources.txt
find "$TEST_SRC_DIR" -name '*.java' > build/test-sources.txt
if [ ! -s build/test-sources.txt ]; then
  echo "Aucune source test trouvée dans $TEST_SRC_DIR"
  exit 0
fi

javac -cp "$FRAMEWORK_JAR:$TOMCAT_HOME/lib/*" -d "$BUILD_CLASSES" @build/test-sources.txt || {
  echo "ERREUR: compilation des sources test a échoué" >&2
  exit 1
}
rm -f build/test-sources.txt

# Copier les .class compilées sous WEB-INF/classes
rsync -a --delete "$BUILD_CLASSES"/ "$OUT_WEBINF_CLASSES"/

# Copier les ressources webapp (JSP, web.xml...) depuis test/WEB-INF (sans framework.jar)
if [ -d "$TEST_SRC_DIR/WEB-INF" ]; then
  mkdir -p "$BUILD_WAR_DIR/WEB-INF"
  rsync -a --delete --exclude 'lib/framework.jar' "$TEST_SRC_DIR/WEB-INF"/ "$BUILD_WAR_DIR/WEB-INF"/
fi

# Copier autres ressources statiques
rsync -a --include='*/' --include='*.html' --include='*.css' --include='*.js' --exclude='*' "$TEST_SRC_DIR"/ "$BUILD_WAR_DIR"/

# Déployer exploded
echo "Déploiement exploded dans $TOMCAT_WEBAPPS/$APP_NAME ..."
rm -rf "$TOMCAT_WEBAPPS/$APP_NAME"
mkdir -p "$TOMCAT_WEBAPPS"
rsync -a "$BUILD_WAR_DIR"/ "$TOMCAT_WEBAPPS/$APP_NAME"/

# S'assurer qu'on n'a pas copié framework.jar dans l'app
if [ -f "$TOMCAT_WEBAPPS/$APP_NAME/WEB-INF/lib/framework.jar" ]; then
  rm -f "$TOMCAT_WEBAPPS/$APP_NAME/WEB-INF/lib/framework.jar"
fi

# Remove Tomcat work dir to force JSP recompilation
if [ -d "$TOMCAT_HOME/work/Catalina/localhost/$APP_NAME" ]; then
  rm -rf "$TOMCAT_HOME/work/Catalina/localhost/$APP_NAME"
fi

echo "Déploiement terminé. Application disponible (si Tomcat en écoute) : http://localhost:8080/$APP_NAME/"