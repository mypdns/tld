#!/usr/bin/env bash

# *********************************************
# Get Travis CI Prepared for Committing to Repo
# *********************************************

PrepareTravis () {
    git remote rm origin
    git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
    git config --global user.email "${GIT_EMAIL}"
    git config --global user.name "${GIT_NAME}"
    git config --global push.default simple
    git checkout "${GIT_BRANCH}"
    ulimit -u
}
PrepareTravis

wget -qO- 'http://data.iana.org/TLD/tlds-alpha-by-domain.txt' | awk '/^(#|$)/{ next }; { printf("%s\n",tolower($1))}' > ${TRAVIS_BUILD_DIR}/tld.list

git add . 
git commit -m "New TLDs"
git push origin master


exit ${?}
