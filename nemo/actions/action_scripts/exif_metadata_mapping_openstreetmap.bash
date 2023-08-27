#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in OpenStreetMap mapping service
# and for evaluation of conditions for related Nemo action to be displayed in the context menu.
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://www.openstreetmap.org/?mlat=${1/, /&mlon=}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
