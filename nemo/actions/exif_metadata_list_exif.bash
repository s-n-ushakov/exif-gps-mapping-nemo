#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of Exif metadata in a Zenity/Nemo dialog using 'exif' utility.
#-----------------------------------------------------------------------------------------------------------------------

# obtain bulk metadata from `exif` utility, skipping the first line
bulk_exif_data=$(exif "$1" | tail --lines=+2)

if [ -n "${bulk_exif_data}" ] ; then
  # source the script file with reusable function definitions
  . "$(dirname "$0")/exif_metadata__functions.bash"

  # obtain GPS position data separately from bulk data
  obtain_gps_position_using_exif "$1"
fi

# prepare the text to be displayed and arrange for rendering
if [ -n "${bulk_exif_data}" ] ; then
  text_to_display="${bulk_exif_data}"
  if [ -n "${gps_position}" ] ; then
    text_to_display+=$'\n'$'\n'
    text_to_display+="GPS coordinates in degrees  : ${gps_position}"
    if [ -n "${altitude}" ] ; then
      text_to_display+=$'\n'
      text_to_display+="Altitude in meters          : ${altitude}"
    fi
  fi
else
  text_to_display="Sorry, no Exif metadata found."
fi
echo "${text_to_display}" \
  | zenity --text-info \
           --title="Exif metadata for $1" \
           --width=700 \
           --height=500 \
           --window-icon=exifinfo \
           --font='DejaVu Sans Mono'
