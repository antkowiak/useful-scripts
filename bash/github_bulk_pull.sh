#!/bin/bash
#
# github_bulk_pull.sh
#
# Bulk pulls all of the repositories for a user in GitHub
#


GITHUB_ROOT=/mnt/c/GitHub/
GITHUB_USER_NAME="antkowiak"


# Scrape GitHub website for all repositories for the given username
GITHUB_REPOS=`wget -q -O - https://github.com/${GITHUB_USER_NAME}?tab=repositories |grep codeRepository |sed -E 's/[^\/]+\/[^\/]+\/([^\"]+).*/\1/g' |sort |uniq`


# Check if the GitHub root directory exists
if [ ! -d "${GITHUB_ROOT}" ]
then
    echo "GitHub directory not found."
    exit
fi


# Start at the GitHub root directory
cd "${GITHUB_ROOT}"


# Iterate over repositories
for REPO_NAME in ${GITHUB_REPOS}
do
    echo -n "Repo: ${REPO_NAME} ... "

    if [ ! -d "${REPO_NAME}" ]
    then
        echo "Dir doesn't exist. Skipping."
    else
        echo "Pulling..."
        cd ${REPO_NAME}
        git pull
        cd "${GITHUB_ROOT}"
    fi
done

