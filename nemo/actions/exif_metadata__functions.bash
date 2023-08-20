#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Definitions of reusable functions for Exif metadata handling scripts.
#-----------------------------------------------------------------------------------------------------------------------

# source the settings file for customizable variables
. "$(dirname "$0")/exif_metadata__settings.bash"

# function to obtain GPS position from a file using 'exif' utility, formatted like '60.000000N, 30.000000W'
# - arguments:
#   - $1 : file path/name
# - output:
#   - latitude and longitude : shared 'gps_position' variable
#   - altitude               : shared 'altitude' variable
obtain_gps_position_using_exif () {
  # obtain specific GPS-related metadata
  local latitude=$(exif --machine-readable --ifd=GPS --tag GPSLatitude "$1")
  local latitude_ref=$(exif --machine-readable --ifd=GPS --tag GPSLatitudeRef "$1")
  local longitude=$(exif --machine-readable --ifd=GPS --tag GPSLongitude "$1")
  local longitude_ref=$(exif --machine-readable --ifd=GPS --tag GPSLongitudeRef "$1")
  altitude=$(exif --machine-readable --ifd=GPS --tag GPSAltitude "$1")

  # if GPS position is present, convert to degrees
  if [ -n "${latitude}" ] ; then
    local latitude_tokens=(${latitude//, / })
    local longitude_tokens=(${longitude//, / })
    local latitude_degrees=$(echo "scale=6 ; ${latitude_tokens[0]} + ${latitude_tokens[1]} / 60 + ${latitude_tokens[2]//,/.} / 3600" | bc)
    local longitude_degrees=$(echo "scale=6 ; ${longitude_tokens[0]} + ${longitude_tokens[1]} / 60 + ${longitude_tokens[2]//,/.} / 3600" | bc)
    gps_position="${latitude_degrees}${latitude_ref}, ${longitude_degrees}${longitude_ref}"
  fi
}

# function to convert coordinates formatted like '60.000000N, 30.000000W' to numeric signed format like
# ('60.000000', '-30.000000')
# - arguments:
#   - $1 : placeholder variable to receive numeric latitude
#   - $2 : placeholder variable to receive numeric longitude
#   - $3 : input data formatted like '60.000000N, 30.000000W'
# - output:
#   - numeric latitude  : $1
#   - numeric longitude : $2
coordinates_as_numeric_signed () {
  # initialize the variable for numeric latitude to be returned as a reference to $1
  local -n lat=$1

  # initialize the variable for numeric longitude to be returned as a reference to $2
  local -n lng=$2

  # parse input data and arrange for output
  local input_data=$3
  if [[ "${input_data}" =~ ^([^NS]+)([NS]),[[:blank:]]([^EW]+)([EW]) ]] ; then
    local lat_abs="${BASH_REMATCH[1]}"
    local lat_sign
    if [ "${BASH_REMATCH[2]}" = 'N' ] ; then
      lat_sign=''
    else
      lat_sign='-'
    fi
    local lng_abs="${BASH_REMATCH[3]}"
    local lng_sign
    if [ "${BASH_REMATCH[4]}" = 'E' ] ; then
      lng_sign=''
    else
      lng_sign='-'
    fi
    lat="${lat_sign}${lat_abs}"
    lng="${lng_sign}${lng_abs}"
  else
    lat=''
    lng=''
  fi
}
