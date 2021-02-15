#!/bin/bash

##############################################################################
#
#  Program :	git_clean v1
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

_msg "Cleaning up repo..."

mv .git/config config
rm -rf .git
sh ./git_setup*
mv config .git/config
git add --all .
git commit -m "Initialise Repo"
git push origin master --force

_msg "Clean up completed..."
