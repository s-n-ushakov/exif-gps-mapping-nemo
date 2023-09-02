#!/bin/bash
#=======================================================================================================================
# Script to copy/install Nemo files in the project to current user profile on local machine.
#=======================================================================================================================

cp --archive --recursive --verbose ./nemo/actions/* "${HOME}/.local/share/nemo/actions" \
  && echo "$0 : INFO : Copied/installed to current user profile on local machine successfully."

