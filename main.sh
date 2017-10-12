#!/bin/bash
projectPath=$(pwd)
remote="origin"
branch="master"
hasPackageChanged=false

function write()
{
  log=$@
  echo "$(date +'%F %X')  $log" >> $logFile
}
source arguments.sh
source git-functions.sh
source npm-functions.sh

parseArguments $@
git="git --git-dir=$projectPath/.git --work-tree=$projectPath"
logFile="${projectPath}/__updates-error.log"

if validArguments; then
  write "Actualizaciones de ${projectPath}"
  while true; do
    if thereAreFilesChanged && gitPull && $hasPackageChanged; then
      npmInstall
    fi
  done
fi
