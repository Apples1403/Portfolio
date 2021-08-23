#!/bin/bash

# Declare variables

#file for the primary web page

output=webpage.txt

#this is the main web page url, but needs to prepended to the url of the actual category/article - cuts down amount to be read

urlprefix="https://cybersecurity-insiders.tradepub.com"

url="https://cybersecurity-insiders.tradepub.com/category/information-technology-security/1091/?"

# Functions

function GetWebPage(){

    # Function to get a web page

    # First parameter is the name of the file to store the web page in

    # Second parameter is the url we  intend to download

    curl -o $1 $2

    # Check for an error and bail if necessary

    [ $? -ne 0 ] && echo "Error Downloading page!" && exit -1

}

function GetAllCategories(){

    # Restrict to single lines relating to the relevant sub categories of Information Security then pipe the output to sed to remove unwanted start and end of lines

    grep -w 'menu_primary_7.*information-technology.*security' "$output" | sed -n -e 's/^.*href="//p' | sed 's/.\{9\}$//' > categories.txt

    # Replace remaining html codes (there are only two ">")  with "%" to act as Field Separator

    sed -i -n -e 's/">/+/p' categories.txt

}

function GetASubCategory(){

    # download the sub category

    # remove any existing file

    if [ -f $1 ]; then

        rm  $1

    fi

    # Get the subcategory requested

    GetWebPage $1 $2

    # Restrict to lines relating to the relevant sub category requested then pipe the output to sed to remove unwanted start and end of lines

    grep -w cardtitle "$1" | sed -n -e 's/^.*href="//p' | sed -n -e 's/.\{4\}$//p'  > allarticles.txt

    # Replace remaining unwanted text with "+" to act as Field Separator

    sed -i -n -e  's/" .*3r">/+/p' allarticles.txt

    # Determine the number of articles in this subcategory

    CatCount="`wc -l <allarticles.txt`"

    cp allarticles.txt  articles.txt

}

function DisplayTable(){

    #First parameter is the name of the file to parse

    # Use awk to print a table consisting of headings and subcategories - along with  a count of the number of articles

    awk 'BEGIN {

        FS="|";

        print"          ____________________________________________________________________________________________";

        print"          | \033[32mCategory No\033[0m  | \033[32m                         Category Name                      \033[0m | \033[032m Articles \033[0m |";

        print"          |______________|______________________________________________________________|____________|";


    }

        {

            printf("          | %-12s | %-60s | %-10s |\n",$1, $2, $3);

        }

   END {


        print"          |______________|______________________________________________________________|____________|";



   }' $TempOut

   # Print footer to table, including sum total number of articles

   echo -e "          | \033[32mTotal Number of Articles in the Information Technology Security Categories \033[0m | \033[032m $TotalArticles     \033[0m |";


   echo "          |_____________________________________________________________________________|____________|";



}

# Main Code

# let the user know that getting the dat a may take a while

echo " "

echo "Please be patient this may take a while...."

echo " "

# Advise user what we are doing

echo " Downloading Main WebPage"

echo " "

# Get the main web page

GetWebPage "webpage.txt" $url

# Extract all the Categories from the main Web page

GetAllCategories

Count="`wc -l <categories.txt`"

TempOut="CategoryCounts.txt"

TotalArticles=0

#Remove any existing file (may be old)

if [ -f $TempOut ]; then

    rm  $TempOut

fi

#for the number of categories we found 


for (( i=1;i<=$Count; i++))

do

    # Obtain the partial url to the actual web page for that category

    Content=`sed -n "$i p" categories.txt`

    shorturl="${Content%%+*}"

    # Obtain the name of the category

    CatName=`cut -d "+" -f2- <<< "$Content"`

    # Create the full url for the web page

    fullurl=$urlprefix$shorturl

    # let the user know

    echo  " "

    echo "Downloading WebPage for Category $CatName"

    echo " "

    GetASubCategory "category.txt" $urlprefix$shorturl

    # keep a running total of the number of articles

    TotalArticles=$(( TotalArticles + CatCount ))

    #Store the data in the output file

    echo "$i| $CatName | $CatCount" >> $TempOut

done

# clear the screen

clear


# Display title

echo -e "\033[32m                                            Cybersecurity Insider Information Technology Security\033[0m"

echo -e "\033[32m                                            =====================================================\033[0m"

echo " "

# Opening statement so the user know what the program does

echo " "

echo "This program interrogates the Cybersecurity Insiders web site and total statistics on Information Technology"

echo "Articles relating to CyberSecurity broken down by sub-categories"

echo " "

#echo "Total Articles = $TotalArticles"

echo " "

# Display the table

DisplayTable

# Tell the user how to exit the program when he/she has finished

echo " "

echo -n -e "\033[31m Please press enter when you have finished \033[0m"

read n

echo " "

exit 0
