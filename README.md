# wow-addon-packager
Batch script for compression an addon into a zip archive ignoring specific files

## Overview

#### How to use
1. Move `packager.bat` file into a root of your addon folder.
2. Run.

#### Dependencies
This script relies on 7zip application for zipping files. You have to have installed 7zip on your PC, expected location: `C:\Program Files\7-Zip\7z.exe`

#### What you will get
The script will create an _output_ folder in a root of your addon folder and compress addon's files into a zip archive with following name '_your_addon_directory version.zip_' (ex. `CombatIndicator v1.2.zip`).
The version will be automatically fetched from a `.toc` file.

#### Ignore
`IGNORE` variable contains names of all directories and files (not recursively) which you don't want to be included in a zip archive.
Initially, this variable contains:
   + .git
   + .idea
   + .gitignore
   + output
   + CONTRIBUTING.md
   + README.md
   + packager.bat
   
but you can edit it as you want.

## Warning
You are using an open source project!
    
I'm not responsible for lost files. Please do some research if you have any concerns 
about features included in this script before using it! YOU are choosing to use this script.
