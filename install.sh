#!/bin/sh
set -eux

# install all modules listed in cpanfile
cpanm --installdeps .
