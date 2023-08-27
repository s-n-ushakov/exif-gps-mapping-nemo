#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata of media files in 2GIS mapping service
# and for evaluation of conditions for related Nemo action to be displayed in the context menu.
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://2gis.ru/search/${1/, /%2C}"
}

# source/call the generic script for handling GPS locations or for action condition evaluation
. "$(dirname "$0")/exif_metadata__mapping.bash"
