#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Definition of customizable varibles to be used in Exif metadata handling scripts.
#-----------------------------------------------------------------------------------------------------------------------

# Web browser to be used to open online mapping services for displaying GPS locations.
# Typical options:
#   BROWSER=xdg-open            # use the default system browser
#   BROWSER=firefox
#   BROWSER=chromium
BROWSER=xdg-open

# ISO 639-1 code for a language to be used when relevant.
# Typical options:
#   LANGUAGE="${LANGUAGE/_*/}"  # use the default system language stripped to language tag only
#   LANGUAGE=en
#   LANGUAGE=ru
LANGUAGE="${LANGUAGE/_*/}"
