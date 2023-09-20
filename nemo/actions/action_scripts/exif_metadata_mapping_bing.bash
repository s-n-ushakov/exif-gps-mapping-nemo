#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata of media files in Bing Maps
# and for evaluation of conditions for related Nemo action to be displayed in the context menu.
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
#
# Still experiments suggest that the simplest 'q=' query is the most efficient...
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  url="https://www.bing.com/maps?setLang=${LANGUAGE}&q=${1/, /%2C+}"
}

# source/call the generic script for handling GPS locations or for action condition evaluation
. "$(dirname "$0")/exif_metadata__mapping.bash"
