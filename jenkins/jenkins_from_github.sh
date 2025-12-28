#
# This is the Jenkins Bash Build script for 
# https://github.com/adligo/slink_bm.ts.adligo.org/
#
# Note exit codes are (original) line numbers unless 0 which is a success,
# If your a maintainer feel free to update when they differ from the line numbers.
# 

### Configuration Section ###
#
# ORIGIN one of {'github','localdisk'}
#
ORIGIN=github
#
# GIT_PROTOCOL one of {'https','ssh','local'}
#
GIT_PROTOCOL=https
GIT_REPOSITORY_BASE=$GIT_PROTOCOL'://github.com/adligo/'
#
# This is used for the directory path as well
#
GIT_REPOSITORY_PATH=slink_bm.ts.adligo.org
GIT_REPOSITORY=$GIT_REPOSITORY_BASE$GIT_REPOSITORY_PATH'.git'

#
# Note the concept of a work dir with a id number, exists because I have seen 
# Jenkins get stopped in the middle of builds creating inconsitent disk states
# This script trys to maximize the speed of git pulls with the flexibility of 
# git clones and clean from scratch builds.
#
WORK_DIR_ID=1

CLEAN=false
CLEAN_WORK_DIR_ID=1
VERBOSE=true
### Execution Section ###
which git
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "Git appears to be installed"
  fi
else
  echo "Please install git on this system and put it in the $PATH variable!"
  exit 44
fi
echo "Running git version"
git -v

which npm
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "Npm appears to be installed"
  fi
else
  echo "Please install Node.js on this system and put npm in the $PATH variable!"
  exit 57
fi
echo "Running npm version"
npm -v

which slink
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "Slink appears to be installed"
  fi
else
  echo "Please install Slink on this system and put npm in the $PATH variable!"
  exit 70
fi
echo "Running slink version"
slink -v


if [[ $CLEAN == "true" ]]; then
  echo "cleaning dir;"
  PWD=`pwd`
  echo $PWD'/'$CLEAN_WORK_DIR_ID
  if [[ -d $CLEAN_WORK_DIR_ID ]]; then
    rm -fr $CLEAN_WORK_DIR_ID
    EXIT_CODE=$?
    if (( $EXIT_CODE == 0 )); then
      echo "Sucessfully removed directory $CLEAN_WORK_DIR_ID"
    else
      echo "Failed to remove directory $CLEAN_WORK_DIR_ID"
      exit 41
    fi
  else
    echo "The following directory doesn't exist!"
    echo $CLEAN_WORK_DIR_ID
    exit 46
  fi
fi

WORK_DIR=`pwd`
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  echo "Sucessfully identified WORK_DIR as"
  echo $WORK_DIR
else
  echo "Failed to identify WORK_DIR"
  exit 57
fi
  
if [[ -d $WORK_DIR_ID ]]; then
  echo "The following directory exists;"
  echo $WORK_DIR_ID
else
  mkdir $WORK_DIR_ID
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    echo "Sucessfully created directory $WORK_DIR_ID"
  else
    echo "Failed to create directory $WORK_DIR_ID"
    exit 70
  fi
fi

cd $WORK_DIR_ID
EXIT_CODE=$?
if (( $EXIT_CODE == 0 )); then
  if [[ $VERBOSE == "true" ]]; then
    echo "Moved into $WORK_DIR_ID"
  fi
else
  echo "Unable to move(change) into directory $WORK_DIR_ID"
  exit 84
fi

if [[ -d $GIT_REPOSITORY_PATH ]]; then
  cd $GIT_REPOSITORY_PATH
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully moved(changed) into $GIT_REPOSITORY_PATH"
    fi
  else
    echo "Unable to move(change) into $GIT_REPOSITORY_PATH"
    exit 96
  fi
  git pull
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully performed a 'git pull' in"
      pwd
    fi
  else
    echo "Unable to run a 'git pull' in"
    pwd
    exit 108
  fi
else
  git clone $GIT_REPOSITORY
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully cloned $GIT_REPOSITORY"
    fi
  else
    echo "Unable to clone $GIT_REPOSITORY"
    exit 119
  fi
fi



function doCd() {
  echo "doingCd"
  
}

function doGitPull() {
  echo "doingGitPull"
  
}

function doHttps() {
  echo "doingHttps"
  
}

function doSsl() {
  echo "doingSsl"
  
}

function doLocal() {
  echo "doingLocal"
  
}
case "$GIT_PROTOCOL" in
  https)
      doHttps
      ;;
  ssl)
      doSsl
      ;;
  *)
      # Commands to execute if none of the above patterns match (default)
      doLocal
      ;;
esac
