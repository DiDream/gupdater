#!/bin/bash
function npmInstall()
{
  logs=$((npm install --prefix ${projectPath}) 2>&1);
  write "Resultado npm install: $logs"
}
