#!/bin/bash -l
# encoding: utf-8
# TODO:
# take a look in repo to see if it can make this process easier
# https://source.android.com/source/developing.html


# Required:
#
# Atlassian-stash - to be able to create pull requests from command line
#
#  sudo gem install --http-proxy http://localhost:3128 atlassian-stash
#  stash configure


# d652209 = Liana
# c737316 = Darren
# d314330 = Jon
# d771685 = George
# d771683 = Sajeesh
# d776957 = Shoaib
# d746996 = Will
# d768199 = Leon


set -o errtrace

function error_exit {
	printf "\n"
	printf "\n"
	printf "\n"
	printf "\n"
	echo " ----------------------------------------------------------------"
	echo "    Error executing script. Verify logs for more information!"
	echo " ----------------------------------------------------------------"
	printf "\n"
	printf "\n"
	printf "\n"
	printf "\n"
	exit 1; 
}

trap error_exit ERR


function merge_and_create_pr() {

	if [[ "$#" -ne 2 ]] ; then
		printf "You have to pass origin and destination branch as arguments."
		exit;
	fi

	MERGE_ORIG_BRANCH=$1
	DEST_BRANCH=$2
	MERGE_DEST_BRANCH="${MERGE_ORIG_BRANCH}_to_${DEST_BRANCH}"

	# Replace '/' with '_'
	MERGE_DEST_BRANCH="${MERGE_DEST_BRANCH//\//_}"

	printf "\n"
	printf " ------------------------------------------------------------\n"
	printf " Started process for branch $MERGE_ORIG_BRANCH to $DEST_BRANCH\n"
	printf " ------------------------------------------------------------\n"


	# Check out/reset destination branch
	printf "\n"
	echo ">>>  Checking out $DEST_BRANCH"; 
	git checkout -B $DEST_BRANCH origin/$DEST_BRANCH
      
	# Create a new branch to merge MERGE_ORIG_BRANCH into the DESTINATION
	AUTOMATED_MERGE_BRANCH="$AUTOMATED_MERGE_PREFIX/$MERGE_DEST_BRANCH"
	printf "\n"
	echo ">>>  Creating merge branch $AUTOMATED_MERGE_BRANCH";
	git checkout -B $AUTOMATED_MERGE_BRANCH 
	 
         #REMOTE_BRANCH_COUNT="$(git branch -r | grep -c origin/$AUTOMATED_MERGE_BRANCH)"
	#echo "Remote count: ${REMOTE_BRANCH_COUNT}"
	#if [ "$REMOTE_BRANCH_COUNT" -ge 1 ]
	#then
		#git pull
	#fi


	# Merge MERGE_ORIG_BRANCH into this branch
	printf "\n"
	echo ">>>  Merging $MERGE_ORIG_BRANCH into $AUTOMATED_MERGE_BRANCH";
	git merge $MERGE_ORIG_BRANCH --no-edit -Xignore-space-change


	# Pushing changes to remote
	printf "\n"
	echo ">>>  Pushing remote branch";
	git push -u origin $AUTOMATED_MERGE_BRANCH

	# Creating pull requests
	printf "\n"
	echo ">>>  Creating pull request";
 	echo "stash pull-request $AUTOMATED_MERGE_BRANCH $DEST_BRANCH $REVIEWERS"
 	stash pull-request $AUTOMATED_MERGE_BRANCH $DEST_BRANCH $REVIEWERS --trace

	printf "\n"
	echo " ------------------------------------------------------------"
	echo " Finished process for merge from $MERGE_ORIG_BRANCH to $DEST_BRANCH"
	echo " ------------------------------------------------------------"
	printf "\n"
	printf "\n"
}

function print_usage {
	printf "    Script format:\n"
	printf "    <script> \"<WORKING_DIR>\" <ORIGIN_BRANCH> <DESTINATION_BRANCH>(Optional) \"<REVIEWERS>\"\n"
	printf "\n"
	printf " Where:\n"
	printf "\n"
	printf "  <WORKING_DIR> = Location where the repository folder can be found.\n"
	printf "\n"
	printf "  <ORIGIN_BRANCH> = Branch name where the merge will be originated. This contains the changes to be merged.\n"
	printf "\n"
	printf "  <DESTINATION_BRANCH> = (Optional) Branch name where the changes will be merged to. If no destination is defined, it will automatically apply for all branches under '_feature/*' \n"
	printf "\n"
	printf "  <REVIEWERS> = List of reviewers for the generated pull request. This is in the format of empty space 'd-numbers' separated by an empty space. E.g.: @d123456 @d654321\n"
	printf "\n"
	printf "\n"

}




NUM_ARGS="$#"

if [[ $NUM_ARGS -lt 3 ]]; then
	printf "\n"
	printf "\n"
	printf "\n"
	printf "\n"
	printf "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
	printf "    Wrong number of arguments.\n"
	print_usage
	printf "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n"
	printf "\n"
	printf "\n"
	printf "\n"
	printf "\n"
	exit 1;
fi


AUTOMATED_MERGE_PREFIX="automated_merge"
IS_FEATURE_BRANCHES=false
WORKING_DIR=$1
ORIGIN_BRANCH=$2
DESTINATION_BRANCH=""


if [[ $NUM_ARGS -eq 3 ]]; then
	IS_FEATURE_BRANCHES=true
	REVIEWERS=$3
fi

if [[ $NUM_ARGS -eq 4 ]]; then
	DESTINATION_BRANCH=$3
	REVIEWERS=$4
fi

if [ -z "$WORKING_DIR" ]
then
   WORKING_DIR='./'
fi





cd ${WORKING_DIR}
printf "\n"
printf " ------------------------------------------------------------\n"
printf " Working diretory: ${WORKING_DIR}\n"
printf " Origin branch: ${ORIGIN_BRANCH}\n"
printf " Destination branch: ${DESTINATION_BRANCH}\n"
printf " Reviewers: ${REVIEWERS}\n"
printf " Load '_feature/*' branches?: ${IS_FEATURE_BRANCHES}\n"
printf " ------------------------------------------------------------\n"
printf "\n"


printf "\n"
echo " ------------------------------------------------------------"
echo "Updating $ORIGIN_BRANCH"
echo " ------------------------------------------------------------"
printf "\n"

git checkout $ORIGIN_BRANCH
git pull


printf "\n"
printf " ------------------------------------------------------------\n"
printf " Finished updating $ORIGIN_BRANCH\n"
printf " ------------------------------------------------------------\n"
printf "\n"


if [ "$IS_FEATURE_BRANCHES" = true ]; then

	printf "\n"
	printf " ------------------------------------------------------------\n"
	printf " Merging feature branches\n"
	printf " ------------------------------------------------------------\n"
	printf "\n"

	# This block will automatically retrieve all _feature/* branches and create merge & Pull request for each one of them
	FEATURE_BRANCHES="$(git branch -r | grep -v HEAD | grep -v ${AUTOMATED_MERGE_PREFIX} | awk -F/ '/\/_feature\//{print $2 "/" $3}')"
	for FEATURE_BRANCH in $FEATURE_BRANCHES; do 
		merge_and_create_pr $ORIGIN_BRANCH $FEATURE_BRANCH;
	done;

else
	printf "\n"
	printf " ------------------------------------------------------------\n"
	printf " Merging destination branch $DESTINATION_BRANCH\n"
	printf " ------------------------------------------------------------\n"
	printf "\n"

	merge_and_create_pr $ORIGIN_BRANCH $DESTINATION_BRANCH
fi