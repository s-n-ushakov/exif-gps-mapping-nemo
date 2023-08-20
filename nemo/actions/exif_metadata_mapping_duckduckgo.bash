#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in DuckDuckGo mapping service, based on Apple Maps.
#
# Description for auto configuration [en]: Display GPS position in 'DuckDuckGo'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'DuckDuckGo'
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  local duckduckgo_locale=ru-ru
  # TODO consider approaches to supplying and handling custom locale data and format
  # TODO verify that 'kl' URL parameter has real effect
  url="https://duckduckgo.com/?iaxm=maps&kl=${duckduckgo_locale}&q=${1/, /%2C+}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
