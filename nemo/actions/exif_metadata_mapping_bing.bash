#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in Bing Maps.
#
# Description for auto configuration [en]: Display GPS position in 'Bing Maps'
# Description for auto configuration [ru]: Показать GPS-позицию в сервисе 'Bing Maps'
#
# See https://learn.microsoft.com/en-us/bingmaps/articles/create-a-custom-map-url
# for URL params description.
#
# See https://github.com/MicrosoftDocs/bingmaps-docs/blob/main/BingMaps/articles/create-a-custom-map-url.md
# for the same description on GitHub
#
# See https://alastaira.wordpress.com/2012/06/19/url-parameters-for-the-bing-maps-website/
# for extra comments.
#
# See https://social.msdn.microsoft.com/Forums/en-US/1ee6dfc4-b4cd-4bfc-a3ad-71acf80c61c3/bing-maps-beta-how-do-i-create-an-http-link-to-bring-up-the-address-on-a-bing-map?forum=vemapcontroldev
# for discussions on Microsoft forum
#-----------------------------------------------------------------------------------------------------------------------

# source the script file with reusable function definitions
. "$(dirname "$0")/exif_metadata__functions.bash"

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  # obtain coordinates in numeric signed format
  declare lat_signed lng_signed ; coordinates_as_numeric_signed lat_signed lng_signed "$1"

  if [ -n "${lat_signed}" ] ; then
    # one of possible implementation options: use 'rtp' url param;
    # looks reliable, but displays an unnecessary 'Directions' pane for route planning
    url="https://www.bing.com/maps?setLang=${LANGUAGE}&rtp=pos.${lat_signed}_${lng_signed}"

    # another possible implementation option: use 'cp' and 'sp' url params;
    # unfinished, as currently produces no visible point/marker on the map
    #   url="https://www.bing.com/maps?setLang=${LANGUAGE}&cp=${lat_signed}~${lng_signed}&sp=point.${lat_signed}_${lng_signed}_titleString_notesString_linkURL_photoURL"
  else
    # make an attempt to display error message in the browser address line
    url="https://_/ERROR: unexpected GPS position syntax: [$1]"
  fi
}

# source/call the generic script for handling GPS locations
. "$(dirname "$0")/exif_metadata__mapping.bash"
