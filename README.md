# SGVLUG Website

Source code fo the San Gabriel Valley Linux User Group.
The url for the site is http://www.sgvlug.org

The site is:
- Generated by [Pelican](http://docs.getpelican.com/)(a Python-based static web generator)
- Hosted on Github Pages
- Most entries generated from SGVTech Meetup events using [meetup2md](https://github.com/omwah/meetup2md.git) script by James McDuffie 

James McDuffie presented on the SGV LUG site. Slides can be found at  
http://sgvlug.github.io/website_presentation

# Getting Started

## Install Dependencies   

Install Pelican and ghp-import
```bash
$ pip install --requirement requirements.txt
```
## Clone Site

Checkout source (read only)
```
$ git clone https://github.com/sgvlug/website.git sgvlug_website
```

If you are added to access list you can clone this way:
```
$ git clone git@github.com:sgvlug/website.git sgvlug_website
```

## Creating a New Post

Open an editor to create a new post:
```
$ vim content/posts/2014-02-13-lightning-talks.md
```

Convention is to name the file with event date, then event title.  The date in the post should be when it was written.

The contents of the post need at least the Title and Date meta data in the header. Contents of the post is regular Markdown below the header lines.
```
Title: Lightning Talks
Date: 2014-02-13 22:33

Paragraphs are separated by a blank line.

2nd paragraph. *Italic*, **bold**, `monospace`. 
Itemized lists look like:

  * this one
  * that one
  * the other one
```

## Testing Website

Pelican includes a small development server so you can see what the site will look like when you deploy it. Run the following:
```
$ make devserver
```

Then navigate to http://localhost:8000/

## Deploying Website

Once you are satisfied with the changes, use git to save your changes and upload to Github:
```
$ git add content/posts/<your_new_file>.md
$ git commit -m "What I did here was add a new post"
$ git push origin master
```

Deploying to github is made easy using ghp-import and Pelican's Makefile:
```
$ make github
```

# Generate Posts from Meetup Events

James made a script to easily convert the contents of the SGVTech meetup events into Markdown for Pelican. It also adds some meta data about the event data and location.

## Setup meetup2md Script

### Obtain meetup2md

Download meetup2md from Github and initialize it's submodules:
```
$ git clone https://github.com/omwah/meetup2md.git
$ git submodule init
$ git submodule update
```

### Authorize meetup2md

We need to set up OAuth so the script can access Meetup. Create a new consumer key and secret here:
http://meetup.com/meetup_api/oauth_consumers

Set up authentication with the program:
```
$ meetup2md.py --consumer <key> <secret>
```

Hit allow on the web page that is loaded by the script. Now pass the verification code to the script:
```
$ meetup2md.py --verifier 183742
```

### Configure meetup2md for LUG

Edit the [events] section of app.cfg to allow us to easily to filter out SGVLUG events:
```
[events]
group_name = SGVTech
name_filter = SGV Linux Users Group Monthly Meeting
title_cleanup = ^SGV Linux Users Group Monthly Meeting -
```

## Creating an Article from a Meetup Event

From the sgvtech_website directory you can create a post for the SGVLUG meetups scheduled within the next month:
```
$ meetup2md.py -t ,1m -o content/posts
```
* -t indicates a time range
* -o specifies where to output files

You will see something like this:
```
Name: SGV Linux Users Group Monthly Meeting - Lightning Talks
Title: Lightning Talks
Time: Thursday February 13, 2014 07:00 PM
Venue: Burger Continental, 535 S Lake Ave, Pasadena, CA, 91101
 -> content/posts/2014-02-13-lightning-talks.md
----
```

## Finishing Up

Load up the devserver to check the post, commit if everything looks fine.  
For more details on arguments to meetup2md.py see the README on Github:  
http://github.com/omwah/meetup2md/
