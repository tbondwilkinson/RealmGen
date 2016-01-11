#!/bin/sh

#  realmGen.sh
#  RealmGen
#
#  Created by Tom Wilkinson on 12/5/15.
#  Copyright © 2015 Tom Wilkinson. All rights reserved.


function usage
{
    echo "usage: realmGen -d swift_directory -s A.swift B.swift -p realm_path -json file.json"
}

json=
reading_swift_files=false
realm_path="./default.realm"
swift_files=()
while [ "$1" != "" ]; do
    if [[ "$1" == -* ]]; then
        reading_swift_files=false
    fi
    if [ "$reading_swift_files" = true ]; then
        swift_files+=("$1")
    else
        reading_swift_files=false
        case $1 in
            -json )  shift
                    json=$1
                    ;;
            -s | -swift_files )
                    reading_swift_files=true
                    ;;
            -d | -swift_directory )
                    shift
                    shopt -s nullglob
                    files=$(find $1 -name "*swift" -type f)
                    for f in $files; do
                        if [[ $f != "./main.swift" ]]; then
                            swift_files+=("$f")
                        fi
                    done
                    ;;
            -p | -realm_path )
                    shift
                    realm_path=$1
                    ;;
            * )     usage
                    exit 1
        esac
    fi
    shift
done
cat ${swift_files[@]} main.swift | swift -F Carthage/Build/Mac - -p $realm_path $json