#!/bin/bash
find ./paht/to/dir -type f -iname "*.mp4" -print0 | while IFS= read -r -d $'\0' file;
  do
    echo "Processing directory: $(dirname "${file}")"
    echo "Processsing file: $(basename "${file}")"

    cp "$file" "tmp.mp4" # copy to avoid "white space" issue

    ######
    ## don't worry about white spaces in the path/name
    ####
    #ffmpeg -i "tmp.mp4" -map_metadata -1 -c:v copy -c:a copy "tmp_no_subs.mp4" < /dev/null ## remove media tags
    ffmpeg -i "tmp.mp4" -sn -c copy "tmp_no_subs.mp4" < /dev/null ## remove subtitles

    mv "tmp_no_subs.mp4" "$(dirname "${file}")/$(basename "${file}")" # move back to the original directory under the original name
    rm "tmp.mp4" # cleanup

done
