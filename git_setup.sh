#!/bin/bash

##############################################################################
#
#  Program :	git_setup v1
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

_msg "Setting up Git Repository!"

git init
git config --global user.name "salientos"
git config --global user.email "d3signr@gmail.com"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple

_msg "Git Repository Setup Complete!"
