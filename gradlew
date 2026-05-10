# !/usr/bin/env sh

################################################################################
#  Gradle startup script for POSIX environments
################################################################################

APP_HOME="$(dirname "$0")"
APP_NAME="Gradle"
APP_BASE_NAME="`basename "$0"`"
APP_ARGS=""

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

# OS specific support.  $var must be set to either "true" or "false".
cygwin=false
darwin=false
msys=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MSYS* | MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum file descriptors if needed
if [ "$cygwin" = "false" -a "$darwin" = "false" -a "$nonstop" = "false" ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ "$MAX_FD_LIMIT" != "unlimited" ] ; then
        ulimit -n $MAX_FD_LIMIT
        if [ $? -eq 1 ] ; then
            warn "Could not set maximum file descriptor limit"
        fi
    fi
fi

# Collect all arguments for the java command, following the shell quoting rules
for arg in "$@" ; do
    case $arg in
        -D* | -X* )
            APP_ARGS="$APP_ARGS $arg"
            ;;
        * )
            APP_ARGS="$APP_ARGS \"$arg\""
            ;;
    esac
done

# by default we should be in the correct project dir, but when run from Finder on Mac, the cwd is wrong
if [ "$(basename "$PWD")" = "MacOS" ] ; then
    cd "`dirname "$0"`/.."
fi

exec "$JAVACMD" $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS "$CLASSPATH" -classpath "$CLASSPATH" -Dorg.gradle.appname="$APP_BASE_NAME" -Dorg.gradle.wrapper.script="$SCRIPT" org.gradle.wrapper.GradleWrapperMain $APP_ARGS
