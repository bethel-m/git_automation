#!/bin/bash
# author: Bethel
# this script automates the process of adding files 
# to the .gitignore file

# to run add files to your gitignore file just type the 
# command "ignore $1 $2 .."where ignore is the command and
# $1 $2 .., are the names of the files to add to the gitignore




#chedk if .gitignore file exist
check_or_create_gitignore(){
    FILE=.gitignore
    if [ -f "$FILE" ]
    then
        echo "--------------------------"
        echo "found .gitignore file"
        echo " "
        echo ".gitignore:"
        cat .gitignore

    else
        echo "--------------------------"
        echo " No .gitignore file found"
        echo "--------------------------"
        echo " creating a .gitignore file ......"
        echo ".gitignore:"
        touch .gitignore
    fi
}

# function to check if the files were added to the .gitignore file
# a function to add files to the gitignore file
add_to_gitignore(){
    echo $1 >> .gitignore
}


# check if .gitignore file exist
check_or_create_gitignore
echo "============================ "
echo "adding your files to .gitignore ..."
# add the arguments individually to the .gitignore file
for i in $*; do 
    
    add_to_gitignore $i
done 

echo ------------------
echo "done adding files"
