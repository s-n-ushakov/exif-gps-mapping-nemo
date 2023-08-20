#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in VK Maps, based on OpenStreetMap data with custom
# rendering and services.
#
# Description for auto configuration [en]: Display GPS position in 'VK Maps'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'VK Карты'
#-----------------------------------------------------------------------------------------------------------------------

# source the script file with reusable function definitions
. "$(dirname "$0")/exif_metadata__functions.bash"

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  # obtain coordinates in numeric signed format
  declare lat_signed lng_signed ; coordinates_as_numeric_signed lat_signed lng_signed "$1"

  if [ -n "${lat_signed}" ] ; then
    url="https://maps.vk.com/ru/find/?q=${lat_signed},+${lng_signed}&lat=${lat_signed}&lng=${lng_signed}&zoom=12"
  else
    # make an attempt to display error message in the browser address line
    url="https://_/ERROR: unexpected GPS position syntax: [$1]"
  fi
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
