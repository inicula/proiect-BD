#!/bin/sh
g++ -std=c++20 -Wall -Wextra -Wpedantic -O3 -fno-exceptions -march=native -flto "$1" -lfmt
