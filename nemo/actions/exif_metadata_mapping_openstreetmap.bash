#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in OpenStreetMap mapping service.
#
# Description for auto configuration [en]: Display GPS position in 'OpenStreetMap'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'OpenStreetMap'
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://www.openstreetmap.org/?mlat=${1/, /&mlon=}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
