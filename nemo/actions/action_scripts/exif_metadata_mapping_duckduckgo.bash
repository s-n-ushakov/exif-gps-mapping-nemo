#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of GPS locations from Exif metadata in DuckDuckGo mapping service, based on Apple Maps,
# and for evaluation of conditions for related Nemo action to be displayed in the context menu.
#
# See https://duckduckgo.com/duckduckgo-help-pages/settings/params/
# for URL params description.
#-----------------------------------------------------------------------------------------------------------------------

# define specific function for URL formatting, specified in 'exif_metadata__mapping.bash'
format_url () {
  local duckduckgo_locale
  if [ "${LANGUAGE}" = 'en' ] ; then
    duckduckgo_locale='us-en'
  elif [ "${LANGUAGE}" = 'ru' ] ; then
    duckduckgo_locale='ru-ru'
  else
    duckduckgo_locale='wt-wt'
  fi
  # TODO consider more consistent approaches to supplying and handling custom locale data
  # TODO verify that 'kl' URL parameter has real effect
  url="https://duckduckgo.com/?iaxm=maps&kl=${duckduckgo_locale}&q=${1/, /%2C+}"
}

# source/call the generic script for handling GPS locations or for action condition evaluation
. "$(dirname "$0")/exif_metadata__mapping.bash"
