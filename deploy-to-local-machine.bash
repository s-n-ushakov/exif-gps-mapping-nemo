#!/bin/bash
#=======================================================================================================================
# Script to copy/deploy Nemo files in the project to the current user profile on local machine.
#=======================================================================================================================

cp -a ./nemo/actions/* "${HOME}/.local/share/nemo/actions" \
  && echo "$0 : INFO : Deployed to current user profile on local machine successfully."

