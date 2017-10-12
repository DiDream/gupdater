#!/bin/bash

function isGitRepo()
{
  erroValidation=$(($git st) 2>&1)
  if [ $? -ne 0 ]; then
    echo "Parece que no es un repositorio git..."
    false
  else
    true
  fi
}
function isBranchCorrect()
{
  erroValidation=$(($git checkout ${branch}) 2>&1)
  if [ $? -ne 0 ]; then
    echo "La rama parece que no existe..."
    false
  else
    true
  fi
}
function isRemoteCorrect()
{
  local remote=$($git remote | grep -w ${remote} | wc -l)
  if [ $remote -eq 0 ]; then
    echo "Nombre de la rama remota errónea...";
    false
  else
    true
  fi
}
function validArguments()
{
  if isGitRepo && isBranchCorrect && isRemoteCorrect; then
    true
  else
    false
  fi
}
function gitPull()
{
  logs=$(($git pull $remote $branch) 2>&1)
  exitCode=$?

  if [ $exitCode -ne 0 ]; then
    write $logs
    false
  else
    true
  fi

}

function thereAreFilesChanged()
{

  local filesChanged=$($git fetch && $git diff --name-only ..${remote})


  local numberFilesChanged=($filesChanged)
  numberFilesChanged=${#numberFilesChanged[@]}

  if [ $numberFilesChanged -gt 0 ]; then

    local packageFiles=$(echo $filesChanged | tr -s " " "\n" | grep -w "package.json" | wc -l)

    write "$numberFilesChanged ficheros modificados => $filesChanged"

    if [ $packageFiles -gt 0 ]; then
      hasPackageChanged=true
    else
      hasPackageChanged=false
    fi

    true
  else
    false
  fi

}
