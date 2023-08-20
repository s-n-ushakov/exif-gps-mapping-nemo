#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in Google Maps.
#
# Description for auto configuration [en]: Display GPS position in 'Google Maps'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'Google Карты'
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://www.google.com/maps/search/${1/, /%2C+}?hl=${LANGUAGE}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
