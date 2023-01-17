#!/bin/bash

error() {
    echo -e "\033[1;31m${1}\033[0m"
}

info() {
    echo -e "\033[1;34m${1}\033[0m"
}

AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:?'AWS_DEFAULT_REGION variable missing.'}

if [[ -n "${AWS_OIDC_ROLE_ARN}" ]]; then
    if [[ -n "${BITBUCKET_STEP_OIDC_TOKEN}" ]]; then
            info 'Authenticating with a OpenID Connect (OIDC) Web Identity Provider.'
            mkdir -p /.aws-oidc
            AWS_WEB_IDENTITY_TOKEN_FILE=/.aws-oidc/web_identity_token
            echo "${BITBUCKET_STEP_OIDC_TOKEN}" >> ${AWS_WEB_IDENTITY_TOKEN_FILE}
            chmod 400 ${AWS_WEB_IDENTITY_TOKEN_FILE}
            aws configure set web_identity_token_file ${AWS_WEB_IDENTITY_TOKEN_FILE}
            aws configure set role_arn ${AWS_OIDC_ROLE_ARN}
            unset AWS_ACCESS_KEY_ID
            unset AWS_SECRET_ACCESS_KEY
    else
        error 'Parameter `oidc: true` in the step configuration is required for OIDC authentication'
    fi
else
    error 'AWS_OIDC_ROLE_ARN pipeline var is required for OIDC authentication'
fi