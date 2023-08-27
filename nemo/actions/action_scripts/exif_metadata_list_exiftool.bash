#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script to implement rendering of Exif metadata for media files in a Zenity/Nemo dialog using 'exiftool' utility.
#
# See 'https://exiftool.org/', 'https://exiftool.sourceforge.net/' and 'https://github.com/exiftool/exiftool'
# for 'exiftool' utility.
#-----------------------------------------------------------------------------------------------------------------------

# obtain bulk metadata from `exiftool` utility
bulk_exif_data=$(exiftool -coordFormat "%.6f" "$1")

# prepare the text to be displayed and arrange for rendering
text_to_display="${bulk_exif_data}"
echo "${text_to_display}" \
  | zenity --text-info \
           --title="Exif metadata for $1" \
           --width=1000 \
           --height=500 \
           --window-icon=exifinfo \
           --font='DejaVu Sans Mono'
