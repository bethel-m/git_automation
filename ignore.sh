#!/bin/bash
# author: Bethel
# this script automates the process of adding files 
# to the .gitignore file

# to run add files to your gitignore file just type the 
# command "ignore $1 $2 .."where ignore is the command and
# $1 $2 .., are the names of the files to add to the gitignore


# this function checks if .gitignore file exists,if it does it displays
#its contents, if it does not , it creates a one
check_or_create_gitignore(){
    FILE=.gitignore
    if [ -f "$FILE" ]
    then
        echo "found .gitignore file"
        echo " -------------------"
        echo ".gitignore:"
        echo "--------------------"
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



#this function adds files to the .gitignore file 
# but if the file already exist in the .gitignore 
# file it skips it
add_to_gitignore(){
    if grep -Fxq $1 .gitignore
   then 
        echo "$1 duplicate found skippping file...."
    else 
        echo $1 >> .gitignore
    fi 
    
}


#this array holds the names of the values or files 
# that were not added to the .gitignore file
files_not_added=()

# variable 
counter=0 #counter to count the number of files succesfully added to the .gitignorefile

# this function checks to see that all the passed arguments
# were added in the .gitignore file. if a file was added it increments
# a counter keeping track of the number added , but if it wasn't added
# it appends it to the files_not_added array
check_if_files_were_added(){
    if grep -Fxq $1 .gitignore
    then 
        let counter++
        echo "$1 is present in gitignore"
    else 
        echo "$1 is not in .gitignore"
        files_not_added+=($1)
    fi
}


# main program


# check if .gitignore file exist
echo "==========================="
check_or_create_gitignore


# adding files to the .gitignore file
echo "============================== "
echo "adding your files to .gitignore ..."
echo "------------------------------"
for i in $*;do
    add_to_gitignore $i
done 

# confirming that all the passed arguments were added to the .gitignore file
echo "=============================="
echo "confirming arguments were successfully added to .gitignore ....."
echo "------------------------------" 
for i in $*; do 
    check_if_files_were_added $i
done 


#confirmimg that the number of arguments equals the counter variable 
# keeping track of the files added to the .gitignore file
# if they are not equal it prints the values in the files_not_added array
if [[ $counter -eq $# ]]
then
    echo "-------------------------------------------------"
    echo "all $counter files confirmed present in .gitnore"
    echo '-------------------------------------------------'
else 
    echo "---------------------------------------------------"
    echo "an error occured: the following files were not added: "
    echo "-----------------------------------------------------"
    for file in "${files_not_added[@]}"
    do
        echo $file
    done 
    echo "---------------------------------------------------"
fi