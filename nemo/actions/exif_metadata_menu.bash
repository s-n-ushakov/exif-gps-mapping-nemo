#! /bin/bash
#-----------------------------------------------------------------------------------------------------------------------
# Script for creating and shaping a list of available specific actions to be taken upon Exif metadata of a media file.
#-----------------------------------------------------------------------------------------------------------------------

# source the settings file for customizable variables
. "$(dirname "$0")/exif_metadata__settings.bash"

# define messages for menu items
declare -A descrition_metadata_exiftool ; descriptions_metadata_exiftool=(
  ['en']="Display Exif metadata using 'exiftool' utility"
  ['ru']="Показать Exif-метаданные посредством утилиты 'exiftool'"
)
declare -A descrition_metadata_exif ; descriptions_metadata_exif=(
  ['en']="Display Exif metadata using 'exif' utility"
  ['ru']="Показать Exif-метаданные посредством утилиты 'exif'"
)

# obtain and parse media file name and MIME type
file_path_name_ext="$1"
file_name_ext=$(basename "${file_path_name_ext}")
mime_type=$(file --brief --mime-type "${file_path_name_ext}")

# prepare a list of actions to select from ...
which_exif=$(which exif)
which_exiftool=$(which exiftool)
items_to_display=()
# ... display all metadata using 'exiftool' utility
if [ -n "${which_exiftool}" ] ; then
  if [ -v "descriptions_metadata_exiftool[${LANGUAGE}]" ] ; then
    description=${descriptions_metadata_exiftool[${LANGUAGE}]}
  else
    description=${descriptions_metadata_exiftool[en]}
  fi
  items_to_display+=('FALSE' 'exif_metadata_list_exiftool.bash' "${description}")
fi
# ... display all metadata using 'exif' utility for JPEG files only
if [ "$mime_type" = 'image/jpeg' ] ; then
  if [ -n "${which_exif}" ] ; then
    if [ -v "descriptions_metadata_exif[${LANGUAGE}]" ] ; then
      description=${descriptions_metadata_exif[${LANGUAGE}]}
    else
      description=${descriptions_metadata_exif[en]}
    fi
    items_to_display+=('FALSE' 'exif_metadata_list_exif.bash' "${description}")
  fi
fi
# ... display GPS position in online mapping services using any plugin scripts found
if [[ ( -n "${which_exiftool}" && -n $(exiftool -Composite:GPSPosition "${file_path_name_ext}") ) || \
      ( -n "${which_exif}" && "$mime_type" = 'image/jpeg' && -n $(exif --ifd=GPS --tag=GPSLatitude "${file_path_name_ext}") ) ]] ; then
  for script_full in "$(dirname "$0")"/exif_metadata_mapping_* ; do
    script=$(basename "${script_full}")
    # try to extract script description for selected language from script internal comments
    description_raw=$(grep "# Description for auto configuration \[${LANGUAGE}\]:" "${script_full}")
    # ... fall back to script description in English
    if [ -z "$description_raw" ] ; then
      description_raw=$(grep "# Description for auto configuration \[en\]:" "${script_full}")
    fi
    # ... fall back to script name as description
    if [ -z "$description_raw" ] ; then
      description_raw="$script"
    fi
    # strip descriprion prefix, if any
    description=${description_raw/*: /}
    # add to the list of available actions to be displayed
    items_to_display+=('FALSE' "${script}" "${description}")
  done
fi

# mark the first item in the list as selected
if [ ${#items_to_display[@]} -ne 0 ] ; then
  items_to_display[0]='TRUE'
fi

# display the list of actions and obtain the selected item
if [ ${#items_to_display[@]} -ne 0 ] ; then
  zenity_list_text='Select action to be taken:'
else
  if [ "$mime_type" = 'image/jpeg' ] ; then
    zenity_list_text="Sorry, no action can be taken, as neither 'exif' nor 'exiftool' utility is available."
  else
    zenity_list_text="Sorry, no action can be taken, as 'exiftool' utility is not available."
  fi
fi
action_selected=$(zenity \
  --list \
  --radiolist \
  --title="Select action for Exif metadata of '${file_name_ext}'" \
  --width=500 \
  --height=350 \
  --text="$zenity_list_text" \
  --column='' --column='Script' --column='Description' \
  --hide-column=2 \
  "${items_to_display[@]}" \
)

# execute the selected action
if [ -n "${action_selected}" ] ; then
  $("$(dirname "$0")/${action_selected}" "${file_path_name_ext}")
fi
