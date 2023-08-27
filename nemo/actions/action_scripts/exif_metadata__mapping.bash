#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Generic script for:
# - handling GPS locations using various online mapping services;
# - evaluation of conditions for related Nemo action to be displayed in the context menu.
#
# Use cases:
# - evaluation whether related Nemo action can be executed and should be displayed in the context menu:
#   - script arguments:
#     - $1 : media file pathname
#     - $2 : '--condition'        # predefined value as use case discriminator
#   - script output:
#     - exit status:
#       - 0 / true  : in case action can be executed
#       - 1 / false : in case action cannot be executed
# - handling GPS location using an online mapping service:
#   - script arguments:
#     - $1 : media file pathname
#     - $2 : undefined / empty
#   - script output:
#     - action: GPS location is opened in a browser
#
# Requires 'format_url' function to be supplied by a caller script:
# - arguments:
#   - $1 : coordinates of a location to be displayed by an online mapping serice, shaped like '60.000000N, 30.000000E'
# - output:
#   - mapping service specific URL : shared 'url' variable
#-----------------------------------------------------------------------------------------------------------------------

# consume command line arguments
file_pathname="$1"
option="$2"

# source the settings file for customizable variables
. "$(dirname "$0")/exif_metadata__settings.bash"

# obtain file MIME type
mime_type=$(file --brief --mime-type "${file_pathname}")

# check which Exif metadata extraction utilities are available
which_exif="$(which exif)"
which_exiftool="$(which exiftool)"

# make an attempt to obtain GPS position
# NOTE 'exif' tool is preferable, as it does not cheat with GPS data availability and zero coordinates
if [ -n "$(which exif)" ] && [ "${mime_type}" = 'image/jpeg' ] ; then
  . "$(dirname "$0")/exif_metadata__functions.bash"   # source the script file with reusable function definitions
  obtain_gps_position_using_exif "${file_pathname}"
elif [ -n "$(which exiftool)" ] ; then
  gps_position_raw=$(exiftool -veryShort -coordFormat '%.6f' -Composite:GPSPosition "${file_pathname}")
  gps_position_1="${gps_position_raw/GPSPosition: /}" # strip tag name prefix
  gps_position_2="${gps_position_1// /}"              # strip all spaces to remove spaces before 'N', 'S', 'E' and 'W/
  gps_position="${gps_position_2/,/, }"               # add a space after comma
else
  gps_position=''
fi

# serve the use case with evaluation of condition whether related Nemo action can be executed
if [ "${option}" = '--condition' ] ; then
  if [ -z "${gps_position}" ] ; then
    exit 1
  else
    exit 0
  fi
fi

# handle interactive case with browser, in case we got here occasionally with GPS position not available
if [ -z "${gps_position}" ] ; then
  "${BROWSER}" "ERROR : GPS position not found in file metadata." &
  exit 1
fi

# define/format 'url' variable as a custom link for online map using the caller supplied function
format_url "${gps_position}"

# open the link in a browser
"${BROWSER}" "${url}" &
