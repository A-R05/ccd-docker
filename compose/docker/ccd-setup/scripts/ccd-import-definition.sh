#!/bin/sh
## Usage: ./ccd-import-definition.sh path_to_definition
##
## Import the given definition in CCD's definition store.
##
## Prerequisites:
##  - Microservice `ccd_gw` must be authorised to call service `ccd-definition-store-api`

if [ -z "$1" ]
then
    echo "Usage: ./ccd-import-definition.sh path_to_definition"
    exit 1
elif [ ! -f "$1" ]
then
    echo "File not found: $1"
    exit 1
fi

binFolder=$(dirname "$0")

userToken="$(/idam-user-token.sh)"
serviceToken="$(/idam-service-token.sh ccd_gw)"

curl \
http://ccd-definition-store-api:4451/import \
-H "Authorization: Bearer ${userToken}" \
-H "ServiceAuthorization: Bearer ${serviceToken}" \
-F file="@$1"