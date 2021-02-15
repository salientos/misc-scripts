#!/bin/bash

##############################################################################
#
#  Program :	git_push v1
#  Arch    :	x86_64
#  Author  :	Silent Robot
#  Website :	https://sourceforge.net/projects/salient-os/
#
##############################################################################

_msg() {
	term_cols=$(tput cols)
	str=":: $1 ::"
	for ((i=1; i<=`tput cols`; i++)); do echo -n ‾; done
	tput setaf 10; printf "%*s\n" $(((${#str}+$term_cols)/2)) "$str"; tput sgr0
	for ((i=1; i<=`tput cols`; i++)); do echo -n _; done
	printf "\n"
}

_msg "Checking for newer files online."

git pull
_msg "Backing up everything in project folder."
git add --all .
_msg "Enter your commit message (optional)"
read input
_msg "Committing to the local repository."
git commit -m "$input"
_msg "Pushing local files to Github."
git push -u origin master

_msg "Git push completed...all done!"
