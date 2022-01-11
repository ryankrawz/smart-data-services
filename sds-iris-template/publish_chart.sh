#!/bin/bash

source ./buildtools.sh

CHART_NAME=${PWD##*/}

msg "Publish chart $CHART_NAME to Dev or Stable?\n"
PS3='Choice: '
options=("Core Services (Unreleased)" "Core Services (Stable)" "Financial Services (Unreleased)" "Healthcare Services (Unreleased)")
select opt in "${options[@]}"
do
    case $opt in
        "Core Services (Unreleased)")
            CHART_REPOSITORY_URL=amirsamary.github.io
            CHART_REPOSITORY_FOLDER=sds-charts-dev
            GIT_REPOSITORY=https://github.com/amirsamary/$CHART_REPOSITORY_FOLDER
            
            break
            ;;
        "Financial Services (Unreleased)")
            CHART_REPOSITORY_URL=amirsamary.github.io
            CHART_REPOSITORY_FOLDER=sds-charts-dev-finserv
            GIT_REPOSITORY=https://github.com/amirsamary/$CHART_REPOSITORY_FOLDER
            
            break
            ;;
        "Healthcare Services (Unreleased)")
            CHART_REPOSITORY_URL=amirsamary.github.io
            CHART_REPOSITORY_FOLDER=sds-charts-dev-healthserv
            GIT_REPOSITORY=https://github.com/amirsamary/$CHART_REPOSITORY_FOLDER
            
            break
            ;;

        "Core Services (Stable)")
            CHART_REPOSITORY_URL=intersystems.github.io
            CHART_REPOSITORY_FOLDER=sds-charts
            GIT_REPOSITORY=https://github.com/intersystems/$CHART_REPOSITORY_FOLDER

            break
            ;;
        *) echo "Invalid Option Selected: $REPLY. Please Select 1 or 2";;
    esac
done

if [ ! -d ../$CHART_REPOSITORY_FOLDER ];
then
    exit_with_error "You don't have the git repository $CHART_REPOSITORY_FOLDER in the right place. Make sure you have clonned $GIT_REPOSITORY as a sibling to this folder before you proceed."
fi

#
# Fixing the icon reference
#
ICON_FILE_NAME=$(ls ./helm/icon.*)
ICON_FILE_NAME=${ICON_FILE_NAME##*/}
sed -E -i '' "s;icon: .*;icon: https://$CHART_REPOSITORY_URL/$CHART_REPOSITORY_FOLDER/$CHART_NAME/$ICON_FILE_NAME;g" ./helm/Chart.yaml

#
# Publishing
#

cd ../$CHART_REPOSITORY_FOLDER
git pull
exit_if_error "Could not pull changes from $GIT_REPOSITORY on your folder $CHART_REPOSITORY_FOLDER. Do you have pending changes there?"

cd ../$CHART_NAME

rm -rf ../$CHART_REPOSITORY_FOLDER/$CHART_NAME
cp -R ./helm ../$CHART_REPOSITORY_FOLDER/$CHART_NAME

cd ../$CHART_REPOSITORY_FOLDER

helm package ./$CHART_NAME
exit_if_error "Packaging of helm chart $CHART_NAME failed."

helm repo index . --url https://$CHART_REPOSITORY_URL/$CHART_REPOSITORY_FOLDER
exit_if_error "Failed to index helm chart $CHART_NAME on your folder $CHART_REPOSITORY_FOLDER."

git add .
exit_if_error "Could not add changes to the staging area of your folder $CHART_REPOSITORY_FOLDER."

git commit -m "Publishing new version of chart $CHART_NAME."
exit_if_error "Could not commit changes."

git push
exit_if_error "Could not push changes."

cd ../$CHART_NAME
