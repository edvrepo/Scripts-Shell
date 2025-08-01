#!/bin/bash
#This script is seed for build projects folders on C++
#script-by-edvrepo

mkdir -p "$1/src" "$1/include" "$1/build"
touch "$1/README.md" "$1/.gitignore"
echo -e "# Proyecto $1\nDescripción del proyecto" > "$1/README.md"
echo -e "build/\n*.o\n*.exe" > "$1/.gitignore"
echo "Estructura creada para el proyecto $1"
