#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in 2GIS mapping service.
#
# Description for auto configuration [en]: Display GPS position in '2GIS'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе '2ГИС'
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://2gis.ru/search/${1/, /%2C}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
