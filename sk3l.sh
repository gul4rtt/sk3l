#!/usr/bin/env bash

args_def=0
libop_def=0
skull=" .-.
(o.o)
 |=|
"
msg="\n[*] The file main.c was successfully created in the current directory!"
help="Usage: ./sk3l <options>

Options:
"

mprint(){
    if [ $libop_def -eq 1 ] && [ $args_def -eq 1 ]; then
        args="int argc, char *argv[]"
        libop="#include <stdlib.h>\n"
    elif [ $libop_def -eq 1 ] && [ $args_def -eq 0 ]; then
        libop="#include <stdlib.h\n"
    elif [ $libop_def -eq 0 ] && [ $args_def -eq 1 ]; then
        args="int argc, char *argv[]"
    fi

    base="#include <stdio.h>\n$libop
    
\nint main($args){\n

\n\treturn 0;\n
}"

if [ -w . ]; then
    echo -e $base > main.c
    echo -e "$skull" $msg
else
    echo -e "$skull" "\n[!] You do not have write permission in the current directory."
    exit 1
fi
}

hprint(){
    echo "$help"
    printf "%-20s  %s\n" "-sl, --stdlib" "Include the stdlib in the code."
    printf "%-20s  %s\n" "-ag, --args" "Define the 'main' Function Signature."
    printf "%-20s  %s\n" "-h, --help" "Show this help."
}

if [ $# -eq 0 ]; then
    mprint 
else
    while test -n "$1"
    do
        case "$1" in
            -ag|--args) args_def=1;;
            -sl|--stdlib) libop_def=1;;
            -h|--help|*) echo "$skull" && hprint && exit 0;;
        esac
        shift
    done

    mprint
fi
