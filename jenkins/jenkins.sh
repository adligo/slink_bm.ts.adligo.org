#
# This is the Jenkins Bash Build script for 
# https://github.com/adligo/slink_bm.ts.adligo.org/
#
# Note exit codes are (original) line numbers unless 0 which is a success,
# If your a maintainer feel free to update when they differ from the line numbers.
# 

VERSION="2025-12-28#2"
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
ROOT_WORKSPACE=`pwd`


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

## Fast setup through env variables, this can be commented out to test discover or the common node_modules code 
export COMMON_NODE_MODULES=$ROOT_WORKSPACE/$WORK_DIR_ID/$GIT_REPOSITORY_PATH/slink_group_deps.ts.adligo.org/node_modules
export TESTS4TS_NODE_MODULE_SLINK=$COMMON_NODE_MODULES
export JUNIT_XML_NODE_MODULE_SLINK=$COMMON_NODE_MODULES
export OBJ_NODE_MODULE_SLINK=$COMMON_NODE_MODULES
export SLINK_NODE_MODULE_SLINK=$COMMON_NODE_MODULES
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

function doRm_fr() {
  rm -fr $1
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    echo "Sucessfully removed directory"
    echo $1
    echo "in"
    pwd
  else
    echo "Failed to remove directory"
    echo $1
    echo "in"
    pwd
    exit 72
  fi
}

if [[ $CLEAN == "true" ]]; then
  echo "cleaning dir;"
  echo "$CLEAN_WORK_DIR_ID"
  if [[ -d "$CLEAN_WORK_DIR_ID" ]]; then
    doRm_fr $CLEAN_WORK_DIR_ID
  fi
fi

function doCd() {
  cd $1
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully moved(changed) into $1"
    fi
  else
    echo "Unable to move(change) into $1"
    exit 79
  fi
  
}

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

doCd $WORK_DIR_ID

if [[ -d $GIT_REPOSITORY_PATH ]]; then
  doCd $GIT_REPOSITORY_PATH
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
  doCd $GIT_REPOSITORY_PATH
fi

function doScript() {
  echo "doingScript $1"
  eval "$1"
  EXIT_CODE=$?
  if (( $EXIT_CODE == 0 )); then
    if [[ $VERBOSE == "true" ]]; then
      echo "Sucessfully ran script"
      echo $1
    fi
  else
    echo "There was a problem executing the following script"
    echo $1
    echo "in"
    pwd
    exit 150
  fi
}

doScript ./slink-group/buildSrc/checkVersions.sh

function doHttps() {
  if [[ $VERBOSE == "true" ]]; then
    doScript ./buildSrc/cloneOrPullDeps.sh --verbose
    doScript ./buildSrc/cloneOrPullLibs.sh --verbose
    doCd slink_group.ts.adligo.org
    doScript ../buildSrc/setupBuildTest.sh --verbose
  else
    doScript ./buildSrc/cloneOrPullDeps.sh
    doScript ./buildSrc/cloneOrPullLibs.sh
    doCd slink_group.ts.adligo.org
    doScript ../buildSrc/setupBuildTest.sh
  fi
}

function doSsl() {
  if [[ $VERBOSE == "true" ]]; then
    doScript ./buildSrc/cloneOrPullDeps.sh --ssl --verbose
    doScript ./buildSrc/cloneOrPullLibs.sh --ssl --verbose
    doCd slink_group.ts.adligo.org
    doScript ../buildSrc/setupBuildTest.sh --ssl --verbose
  else
    doScript ./buildSrc/cloneOrPullDeps.sh --ssl
    doScript ./buildSrc/cloneOrPullLibs.sh --ssl
    doCd slink_group.ts.adligo.org
    doScript ../buildSrc/setupBuildTest.sh --ssl
  fi
}

echo "in jenkins_from_github.sh"
pwd
doCd slink-group

case "$GIT_PROTOCOL" in
  https) doHttps
      ;;
  ssl)
      doSsl
      ;;
  *)
      # Commands to execute if none of the above patterns match (default)
      doLocal
      ;;
esac

doCd $ROOT_WORKSPACE
if [[ -d "test-results" ]]; then
  doRm_fr test-results
fi

mkDir test-results
# gh_slink_bm.ts.adligo.org/1/slink_bm.ts.adligo.org/slink-group/slink_group.ts.adligo.org/
cp -r $ROOT_WORKSPACE/$WORK_DIR_ID/$GIT_REPOSITORY_PATH/slink-group/slink_group.ts.adligo.org/depot/test-results/**.*xml test-results
# rsync -avm --include='*.xml' -f 'hide,! */' $ROOT_WORKSPACE/$WORK_DIR_ID/$GIT_REPOSITORY_PATH/slink_group.ts.adligo.org/depot/test-results test-results/
echo "You can now publish using the JUnit Test Repoter with the following path;"
echo "test-results/**.*xml"

echo "Sucessfully ran the jenkins.sh script version $VERSION!"