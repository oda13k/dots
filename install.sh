#!/bin/bash

# Copyright Olaru Alexandru
# Distributed under the MIT license

function help()
{
    printf "Usage: $0 [OPTIONS]\n"
    printf "Install dots\n"
    printf "\n"
    printf "Options:\n"
    printf "  -h, --help Print this message and exit\n"
    printf "  --prefix   Prefix to use when copying files. By default /\n"
    printf "  --user     Name of the user for which to copy files. By default \$USER\n"
}

while [[ $# -gt 0 ]]
do
	key="$1"
	case "$key" in
		"-h"|"--help")
			help
            exit
		;;
		"--prefix")
            if [[ $# == 1 ]]; then  
                help
                printf "\n --prefix requires a value.\n"
                exit 1
            fi 

            PREFIX="$2"
            shift 2
		;;
        "--user")
            if [[ $# == 1 ]]; then  
                help
                printf "\n --user requires a value.\n"
                exit 1
            fi 

            USER_EXP="$2"
            shift 2
        ;;
		*)
            help
            printf "\nUnknown argument \"${key}\".\n"
            exit 1
		;;
	esac
done

if [[ -z "$USER_EXP" ]]; then
    printf "No --user was specified. The default is \"$USER\".\n"
    printf "Do you wish to process (y/n): "
    read RESPONSE

    if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
        exit
    fi

    USER_EXP="$USER"
fi

if [[ -z "$PREFIX" ]]; then
    printf "No --prefix was specified. The default is /\n"
    printf "Do you wish to proceed (y/n): "
    read RESPONSE

    if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
        exit
    fi

    PREFIX="/"
elif [[ $PREFIX != /* ]]; then
    printf "The prefix you provided is not an absolute path!\n"
    exit 1
fi

SCRIPTDIR="$(dirname $0)"

DIRS="${SCRIPTDIR}/etc"
HOME_DIR="${SCRIPTDIR}/home"


for DIR in "$DIRS"
do
    FILES=$(find ${DIR} -type f)

    for FILE in $FILES
    do
        DEST_FILE="${PREFIX}/${FILE#"${SCRIPTDIR}/"}"
        
        if ! [[ -f "${DEST_FILE}" ]]; then
            mkdir -p $(dirname ${DEST_FILE})
            cp ${FILE} ${DEST_FILE}
        else
            diff ${FILE} ${DEST_FILE} > /dev/null
            if [[ "$?" != "0" ]]; then
                printf "File ${DEST_FILE} has changed.\n"
                printf "Overwrite (y/n): "
                read RESPONSE

                if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
                    continue
                fi

                cp ${FILE} ${DEST_FILE}
            fi
        fi
    done
done

if ! [[ -z "$HOME_DIR" ]]; then
    FILES=$(find ${HOME_DIR} -type f)

    for FILE in $FILES
    do
        DEST_FILE="${FILE#"${SCRIPTDIR}/"}"
        DEST_FILE="${PREFIX}/${DEST_FILE/home\/__user/home\/${USER_EXP}}"

        if ! [[ -f "${DEST_FILE}" ]]; then
            mkdir -p $(dirname ${DEST_FILE})
            cp ${FILE} ${DEST_FILE}
        else
            diff ${FILE} ${DEST_FILE} > /dev/null
            if [[ "$?" != "0" ]]; then
                printf "File ${DEST_FILE} has changed.\n"
                printf "Overwrite (y/n): "
                read RESPONSE

                if [[ "$RESPONSE" != "y" && "$RESPONSE" != "Y" ]]; then
                    continue
                fi

                cp ${FILE} ${DEST_FILE}
            fi
        fi
    done
fi

