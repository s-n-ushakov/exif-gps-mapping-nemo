#!/bin/bash
#=======================================================================================================================
# Script to compare Nemo files in the project to the ones existing on local machine.
#=======================================================================================================================

diff ./nemo/actions/ "${HOME}/.local/share/nemo/actions/" \
  && echo "$0 : INFO : No differences found."
