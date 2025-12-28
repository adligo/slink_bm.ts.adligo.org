#
# This is the Jenkins Bash Build script for 
# https://github.com/adligo/slink_bm.ts.adligo.org/
#
# Note exit codes are (original) line numbers unless 0 which is a success,
# If your a maintainer feel free to update when they differ from the line numbers.
# 

VERSION="2025-12-28#1"
### Configuration Section ###

CLEAN=false
CLEAN_WORK_DIR_ID=1


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
    exit 29
  fi
}

if [[ $CLEAN == "true" ]]; then
  echo "cleaning dir;"
  echo "$CLEAN_WORK_DIR_ID"
  if [[ -d "$CLEAN_WORK_DIR_ID" ]]; then
    doRm_fr $CLEAN_WORK_DIR_ID
  fi
fi