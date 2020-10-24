# DK30 Fall 2020 Game Jam (Working Title Still Pending)
Hey! This is the main README for the project. Start here if you need a reference point/how to get started.

Overview/summary of main software tools used recommended for development:
- GameMaker Studio 2
  - Our Main Development tool.
- GitKraken
  - A really nice Git GUI. It's free for public repositories! (which this is)
- TODO: More software, maybe for editing pixel art or Audacity (sound/music)

## 1. First-time Setup
Download the latest version of GameMaker Studio 2 here: https://www.yoyogames.com/get (free trial 30 days)
These instructions and files were created and tested specifically using IDE v2.3.0.529 and Runtime v2.3.0.401

GMS2 Trial Limitations: https://help.yoyogames.com/hc/en-us/articles/230407528-GameMaker-Studio-2-Trial-Limitations
TL;DR: No significant restrictions besides inability to create final exectuables (at least one of us has a license so ask them to do it). Otherwise you should be able to compile on your local machine with impunity.

Download GitKraken here: https://www.gitkraken.com/ (or if you're feeling brave, just roll with Git command line)
Clone it someplace nice on your local machine, then in GMS2 open the .yyp project file in the root directory.

Hit F5 to run it and test it out. Start poking at it! TODO: More details here.

## 2. Development
More In-depth details about development tools and how we can use it to contribute to the project.
Target Aspect Ratio: 16:9
Target Camera Resolution: 480x270
Default Viewport: 1280x7

### 2.1. Software

#### 2.1.1. Game Maker Studio 2
TODO: Details

#### 2.1.2. GitKraken
GitKraken is pretty cool. TODO: How to use for people who don't use Git often.

### 2.2. Other Resources
If you want to contribute in other ways besides programming, here are some suggestions:
- Playtesting
- Sound effects and Music
  - Sound Effects generator: http://drpetter.se/project_sfxr.html 
  - Free Sound effects: https://freesound.org/
- Sprite Art (Pixel Art)
  - If you can make this, great! Otherwise there's a ton of royalty free options we can use out there.
  - https://opengameart.org/

## 3. Style Guides

### 3.1. GML (Game Maker Language)
Try to match existing structures and naming conventions if possible (i.e. if an object is named `oPlayer` then use `oEnemy`, if `o_player` then use `o_enemy`.)

Denote local variables starting with an underscore (i.e. `var _distance = 10;`)

## 4. Running the game

### 4.1. Obtain the .exe
Load up the project in GameMaker and hit Create Executable (ctrl+F8).  You can create an installer or a .zip file - personally, I find the zip file quicker and easier.
Put the zip file somewhere and extract it.  The .exe to run the game will be in there.

### 4.2. Connecting two players
For this step, whoever is acting as the "server" player will need to a) forward port 25653 on their router, and b) send their IP address to the "client" player
Port forwarding will vary based on your internet provider or router, there should be an easy guide if you google it.  You need to forward port 25653 (as of this edit - it's in o_server's create event).
There are a couple of ways to obtain your IP.  I just run ipconfig from my command line and look for the IPv4 Address line.  
