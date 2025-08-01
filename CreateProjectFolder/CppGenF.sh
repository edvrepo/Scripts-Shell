#!/bin/bash
# This script creates a C++ project folder structure with initial files
# script-by-edvrepo-skyfalldev
#email:skdev@proton.me
# Set project name with default value
PROJECT_NAME="${1:-MyProject}"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{include,src,build,docs,tests}

# Create basic files
touch "$PROJECT_NAME"/{.gitignore,CMakeLists.txt,Makefile}

# Create main.cpp
cat <<EOF > "$PROJECT_NAME/src/main.cpp"
#include <iostream>
#include "utils.h"

int main() {
    std::cout << "¡Hola, $PROJECT_NAME!\\n";
    return 0;
}
EOF

# Create utils.h header
cat <<EOF > "$PROJECT_NAME/include/utils.h"
#pragma once

void print_hello();
EOF

# Create CMakeLists.txt
cat <<EOF > "$PROJECT_NAME/CMakeLists.txt"
cmake_minimum_required(VERSION 3.10)
project($PROJECT_NAME)

set(CMAKE_CXX_STANDARD 17)
add_executable(\${PROJECT_NAME} src/main.cpp)
EOF

# Create .gitignore
cat <<EOF > "$PROJECT_NAME/.gitignore"
# Binaries
build/
*.o
*.exe

# IDE files
# Add your IDE specific ignores here
EOF

# Create Makefile
cat <<EOF > "$PROJECT_NAME/Makefile"
CXX = g++
CXXFLAGS = -std=c++17 -Iinclude -Wall

SRC = src/main.cpp
TARGET = build/$PROJECT_NAME

all:
\t\$(CXX) \$(CXXFLAGS) \$(SRC) -o \$(TARGET)

clean:
\trm -f \$(TARGET) *.o

.PHONY: all clean
EOF

# Function to install tree if needed
install_tree() {
    echo "Installing the 'tree' commnad to display directories..."
    
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y tree
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y tree
    elif command -v yum &> /dev/null; then
        sudo yum install -y tree
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm tree
    elif command -v brew &> /dev/null; then
        brew install tree
    else
        echo "Could not install tree automatically."
        return 1
    fi
}

# Check and install tree if not available
if ! command -v tree &> /dev/null; then
    if ! install_tree; then
        echo "ℹ️ Using the basic alternative. For better viewing, install tree manually.:"
        echo "   Debian/Ubuntu: sudo apt install tree"
        echo "   Fedora: sudo dnf install tree"
        echo "   Arch: sudo pacman -S tree"
        echo "   macOS: brew install tree"
        SHOW_TREE=false
    fi
fi

# Display project structure
echo -e "\n Structure created for '$PROJECT_NAME':"
if [ "${SHOW_TREE:-true}" != false ] && command -v tree &> /dev/null; then
    tree "$PROJECT_NAME" --dirsfirst -L 2
else
    find "$PROJECT_NAME" -maxdepth 2 -type d | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
    echo -e "\nMain files:"
    ls -1 "$PROJECT_NAME"/{src/main.cpp,include/utils.h,CMakeLists.txt,Makefile,.gitignore}
fi
