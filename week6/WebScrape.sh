#!/bin/bash

# Declare variables

#Set the Number of lines to Display

DisplayLines=40

# This is the file we will dump the web page into

output=webpage.txt

# url prefix to cybersecurity-insiders - needed to generate a full url for some of the pages

urlprefix="https://cybersecurity-insiders.tradepub.com"

#full url for the web page containing the information technology security stuff

url="https://cybersecurity-insiders.tradepub.com/category/information-technology-security/1091/?"

# Functions

function GetWebPage(){

    # Parameter 1 - name of the file to dump the web page into

    # Parameter 2 - url to the web page we are scraping

    echo " "

    echo -e "Downloading Requested Web Page.........."

    echo " "

    curl -o $1 $2

    #catch any error and exit out

    [ $? -ne 0 ] && echo "Error Downloading page!" && exit -1

}

function GetAllCategories(){

    #process the dumped data in file whose name is $output and store it in categories.txt

    # Restrict to single lines relating to the relevant sub categories of Information Technology Security then pipe the output to sed to remove unwanted start and end of lines

    grep -w 'menu_primary_7.*information-technology.*security' "$output" | sed -n -e 's/^.*href="//p' | sed 's/.\{9\}$//' > categories.txt

    # Replace remaining html codes (there are only two ">")  with "%" to act as Field Separator

    sed -i -n -e 's/">/+/p' categories.txt

}

function GetASubCategory(){

    # Parameter 1 - name of file to dump scraped data into

    # Parameter 2 - url which is to be scraped

    # remove any existing file

    if [ -f $1 ]; then

        rm  $1

    fi

    # Get the webpage

    GetWebPage $1 $2

    # Restrict to lines relating to the relevant sub category requested then pipe the output to sed to remove unwanted start and end of lines

    grep -w cardtitle "$1" | sed -n -e 's/^.*href="//p' | sed -n -e 's/.\{4\}$//p'  > allarticles.txt

    # Replace remaining unwanted text with "+" to act as Field Separator

    sed -i -n -e  's/" .*3r">/+/p' allarticles.txt

    # Calculate the number of articles for this category (basically line count)

    CatCount="`wc -l <allarticles.txt`"

    # Restrict the file to the first "DisplayLines" articles so they can all be displayed on screen

    head -n $DisplayLines allarticles.txt > articles.txt

}

function GetArticleDetail(){

    # Parameter 1 - name of file to dump article detail into

    # Parameter 2 - url of web page to scrape

    # remove any existing file

    if [ -f $1 ]; then

        rm  $1

    fi

    # get article detail page

    GetWebPage $1 $2

    # Restrict to lines relating title and detailed description

    awk '/"splashb"/{x=NR+5}(NR<=x){print}' fulldetail.txt  > detail.txt

    # remove html codes

    sed -i -e 's/<[^>]*>/ /g' detail.txt

    # replace publishers printing code sequences by the character they represent - not sure I have caught them all

    sed -i '
        s|&#8217;|\`|g
        s|&rsquo;|\`|g
        s|&ldquo;|\"|g
        s|&minus;|\-|g
        s|&nbsp;| |g
        s|&#39;|\`|g
        s|&quot;|\"|g
    '  detail.txt
}

function DisplayMainHeading(){

    # Display header

    clear

    echo -e "\033[32m                                                      Information Technology - Security Resources \033[0m"

    echo -e "\033[32m                                                      =========================================== \033[0m"

    echo " "

    # Display description

    echo "The following resources are from cybersecurity-insiders.com.  This web site has an extremely large repository of articles and other resources."

    echo "The list of resources displayed has been deliberately limited to Information Technology articles relating to Security."

    echo "A list of sub-categories will be displayed. When you select a category, a list of the 50 most popular articles in that category will be displayed"

    echo "Enter the line number of an article which is of interest to you and you will be shown a precis of the article."

    echo "When you have seen enough type in 0 to exit the program"

    echo " "

}

function DisplayCategoryHeading(){

    # Display heading

    clear

    echo -e "\033[32m                                                                    Category: $CatName \033[0m"

    # Display description

    echo " "

    echo " These are the 50 most popular articles in the category $CatName out of a total of $CatCount articles in this category"

}

function DisplayTable(){

    # Parameter 1 - name of file to display

    awk 'BEGIN {

        FS="+";

        print"          ___________________________________________________________________________________";

        print"          | \033[32m Line \033[0m | \033[32m                               '$2'                                \033[0m|";

        print"          |________|________________________________________________________________________|";



    }

        {

            printf("          | %-6s | %-70s | \n",NR, $2);

        }

   END {


           print"          |________|________________________________________________________________________|";


    }' $1

}

function DisplayArticleDetail(){

    # Display Article Title

    clear

    echo -e "\033[032m                                   $ArticleName \033[0m"
    echo " "

    # Display sub- title

    sed -n 2p detail.txt

    echo " "

    # Display article detail

    sed -n 6p detail.txt | fold -w 80 -s

    echo " "

    echo " "

    # Wait for user input before continuing

    echo -n -e "\033[31m Please press enter when you have finished \033[0m"

    read n
}

# Main Code

# Download Initial web page

GetWebPage "webpage.txt" $url

# process downloaded data only keeping lines with sub-category data

GetAllCategories

# Get the number of sub-categories (line count)

Count="`wc -l <categories.txt`"

# infinite loop - we will use exit 0 to get out

while :
do

    # Display list of categories

    clear

    DisplayMainHeading

    DisplayTable "categories.txt" "Category"

    #set initial value to ensure we pass thru loop at least once

    LineNo=99

    # Keep looping until we get a number in the required range

    until ((LineNo >= 0 && LineNo <= Count))

    do

        # ask the user which sub-category he wishes to vieq

        echo " "

        read -p "Please enter the number corresponding to sub-category you wish to view (or enter 0 to exit): " LineNo

        echo " "

    done

    # cater for  empty variable

    if [ -z "$LineNo" ]; then

        LineNo=0

    fi

   # The user wants out!

    if [ $LineNo = 0 ]; then


        echo "Thank you for visiting and Goodbye!"

        echo " "

        exit 0

    fi

    # retrieve category

    Content=`sed -n "$LineNo p" categories.txt`

    shorturl="${Content%%+*}"

    CatName=`cut -d "+" -f2- <<< "$Content"`

    fullurl=$urlprefix$shorturl

    # Get the resulting sub-category

    GetASubCategory "category.txt" $urlprefix$shorturl
    # Initial value to ensure we get into the loop at least once

    ArticleNo=99

    #loop until user enters a "0"

     while [ $ArticleNo > 0 ]

     do

        until ((ArticleNo >= 0 && ArticleNo <= 50))

        do

           #clear screen

           clear

            # Display category heading

            DisplayCategoryHeading

            # Display table of articles

            DisplayTable "articles.txt" "Articles"

            # Accept input from the user for the number of the article to view

            echo " "

            read -p "Please enter the number corresponding to the article which you wish to view (or enter 0 to exit):  " ArticleNo

            echo " "

        done

        # cater for empty variable

        if [ -z "$ArticleNo" ]; then

            ArticleNo=0

        fi

        # If the user entered "0" - break out of loop

        if [ $ArticleNo = 0 ]; then

            break

        fi

        # set up the parameters

        # extract the url and article name

        Article=`sed -n "$ArticleNo p" articles.txt`

        Articleurl="${Article%%+*}"

        ArticleName=`cut -d "+" -f2- <<< "$Article"`

        # Get the article detail

        GetArticleDetail "fulldetail.txt" $Articleurl

        # Display the article detail

        DisplayArticleDetail

        ArticleNo=99

    done

done

exit 1

