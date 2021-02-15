#!/bin/sh

#------------------------------------------------------------------------------
# Project Name      - LearnLinux/Miscellaneous Scripts/thumbnail-generator.sh
# Started On        - Thu 14 Jan 20:54:57 GMT 2021
# Last Change       - Sat 16 Jan 03:23:37 GMT 2021
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#------------------------------------------------------------------------------
# Crappy thumbnail generator, because the people demand it!
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Modified	    - Sun 14 Feb 07:20:05 GMT 2021
# Author	    - Silent Robot
#
# Added the ability to draw a box around the text output to contrast against
# the background image with opacity settings in short form as Convert accepts.
#------------------------------------------------------------------------------

prognme=${0##*/}

# Output Styles ---------------------------------------------------------------

bol="$(tput bold)"		#bold
red="$(tput setaf 1)"		#red
blu="$(tput setaf 4)"		#blue
nor="$(tput sgr0)"		#normal
nl="\n"

# Main Options ----------------------------------------------------------------

Font='Fira-Sans-Semibold'
FontSize='70'
Text=$1
TxBgColor='#000a' 		# convert shortened hex, last digit is alpha value
TxFgColor='#fffe' 		# convert shortened hex, last digit is alpha value
TxBoxPadding='250'
Blur='10'
#Resize='1280x720!'		# Optional flag to disrespect aspect ratio on resize
Resize='1280x720'
Original="$HOME/Pictures/thumbnail.jpg"
Output="$HOME/Pictures/yt_thumbnail.jpg"

#------------------------------------------------------------------------------

Err(){
	printf "${nl}${bol}:: ${prognme}: ${red}ERROR${nor} - %s$2${nl}" 1>&2
	[ $1 -gt 0 ] && exit $1
}

[ $# -ne 1 ] && Err 1 'Thumbnail annotation string required!'

command -v convert 1> /dev/null 2>&1 || Err 1 "Dependency 'convert' not met!"
command -v feh 1> /dev/null 2>&1 || Err 1 "Dependency 'feh' not met!"

#------------------------------------------------------------------------------

# convert original and resize the image to the output image
convert "$Original" -auto-level -background '#000000' -vignette 0x300+-1-1\
		-channel RGBA -blur 0x"$Blur" -resize "$Resize" "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

#------------------------------------------------------------------------------

# get width of the new ouput file
width=`identify -format %w "$Output"`;\

# add the textbox with text overlay 
convert -background "$TxBgColor" -fill "$TxFgColor" -gravity center\
		-antialias -pointsize "$FontSize"\
  		-font "$Font" -size "$width"x"$TxBoxPadding"\
   		caption:"$Text" $Output +swap -gravity center -composite "$Output"

[ $? -eq 0 ] && Err=$((Err + $?))

#------------------------------------------------------------------------------

# If '0', then no errors occurred, so display image.
[ $Err -eq 0 ] && feh "$Output"
