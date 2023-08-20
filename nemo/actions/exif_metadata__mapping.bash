#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Generic script for handling GPS locations using various mapping services.
#
# Requires 'format_url' function to be supplied by a caller script:
# - arguments:
#   - $1 : coordinates of a location to be displayed by an online mapping serice, shaped like '60.000000N, 30.000000E'
# - output:
#   - mapping service specific URL : shared 'url' variable
#-----------------------------------------------------------------------------------------------------------------------

# source the settings file for customizable variables
. "$(dirname "$0")/exif_metadata__settings.bash"

# obtain GPS position from Exif metadata using one of available Exif-related utilities, e.g.: '60.000000N, 30.000000E'
if [ -n "$(which exiftool)" ] ; then
  gps_position_raw=$(exiftool -veryShort -coordFormat '%.6f' -Composite:GPSPosition "$1")
  gps_position_1="${gps_position_raw/GPSPosition: /}" # strip tag name prefix
  gps_position_2="${gps_position_1// /}"              # strip all spaces to remove spaces before 'N', 'S', 'E' and 'W/
  gps_position="${gps_position_2/,/, }"               # add a space after comma
elif [ -n "$(which exif)" ] ; then
  # source the script file with reusable function definitions
  . "$(dirname "$0")/exif_metadata__functions.bash"

  obtain_gps_position_using_exif "$1"
else
  "${BROWSER}" "ERROR : neither of 'exiftool' or 'exif' utilities is available." &
  exit 1
fi

# define/format 'url' variable as a link for online map using the caller supplied function
format_url "${gps_position}"

# open the link in a browser
"${BROWSER}" "${url}" &
