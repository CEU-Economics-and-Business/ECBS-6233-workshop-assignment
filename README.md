# ECBS-6233-workshop-assignment

## Instructions

Your task is to write code to be modified under version control. The code should create a dataset which will then be used for analysis. The data for the assignment comes from the paper “The effect of fast-food restaurants on obesity and weight gain” by Currie et al (2010) published in the American Economic Journal: Economic Policy. The paper examines how proximity to fast-food restaurants affects the weight outcomes of children and pregnant women. 

You will work in teams to practice sharing code. Help one another. Also, ask for help early. This is not a test of how well you have memorized some Stata commands, this is a practice exercise for you to get proficient in reproducible analysis in Stata using version control. Don’t be afraid to make mistakes.

Detailed tasks:

## Step 1

Team up with your assigned collaborator.  Divide the tasks within the team using Slack (Check your inbox for an invitation to the course channel). You can decide on a private channel.

## Step 2

In your computer set up a folder named obesity. This is your local repository. 
Publish your local repository on GitHub. This should be one repository per team. Name your remote repository Assignment-Team-number. Number is your assigned team number.
In the obesity folder, create the directory structure that has data and code (as seen in class)
Download the data from the AEJ website and save the data in the data/raw folder.
Use gitignore to have git ignore everything in the data folder: Create a file called .gitignore and add “data/” to it. From shell, go to the obesity folder using cd command, afterwards type:
echo data/ > .gitignore
git add .gitignore
Create a new do-file, or a txt, named “cleandata” and save it in the code folder

## Step 3

Write code that converts raw input data into a dataset ready for analysis. After each of the three steps below, you should (i) stage the do-file (ii) commit the changes to your local system (iii) push the changes to your remote repository. Don’t rename the do-file it defeats the purpose of version control. 

Generate a loop which combines the datasets SchoolData<year>.dta, with SchoolRestaurantData<year> and SchoolCensusData<year>.dta. by matching on the schoolcode variable. Use the merge command for this.
 Create labels for the variables ffood and afood and label the values attached to each variable. 
Combine the yearly files into a panel dataset ready for analysis. Save the data in the “data/derived” folder. 

## Step 4

Invite Arieda and Miklos to the GitHub repository. Settings / Collaborators / Invite. Type full name and select.


