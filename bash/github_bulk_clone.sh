#!/bin/bash
#
# github_bulk_clone.sh
#
# Bulk clones all of the repositories for a user in GitHub
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

    if [ -e "${REPO_NAME}" ]
    then
        echo "File/Dir already exists. Skipping."
    else
        echo "Cloning..."
        git clone https://github.com/${GITHUB_USER_NAME}/${REPO_NAME}

        if [ -d "${REPO_NAME}" ]
        then
            cd ${REPO_NAME}
            git remote set-url origin git@github.com:${GITHUB_USER_NAME}/${REPO_NAME}.git
            cd "${GITHUB_ROOT}"
        fi
    fi
done

