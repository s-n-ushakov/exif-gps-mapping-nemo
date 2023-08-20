#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in Yandex Maps.
#
# Description for auto configuration [en]: Display GPS position in 'Yandex Maps'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'Яндекс Карты'
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://yandex.ru/maps/?text=${1/, /%2C+}"
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
