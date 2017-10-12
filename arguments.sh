#!/bin/bash
usage()
{
  echo "usage: [-p | --path] [-r | --remote ] [-b | --branch]"
  echo "-------------------------------------------------------"
  echo "* [ -p | --path ] Ruta del proyecto con git. Si no se especifica será la ruta del directorio actual."
  echo "* [ -r | --remote ] Nombre del repositorio remoto del proyecto. Por defecto \"origin\""
  echo "* [ -b | --branch ] Nombre de la rama. Por defecto \"master\""
}
parseArguments()
{
  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help )
        usage
        # exit 0 # Cierra terminal en Mac Os
      ;;
      -p | --path )
        shift
        projectPath=$1

      ;;
      -r | --remote )
        shift
        remote=$1

      ;;
      -b | --branch )
        shift
        branch=$1

      ;;
      "");;
      * )
        usage
      ;;
    esac
    shift
  done
}
