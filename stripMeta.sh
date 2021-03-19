#!/bin/bash
find /path/to/dir/ -type f -iname "*.mkv" -print0 | while IFS= read -r -d $'\0' file;
  do
    echo "Processsing file: $(basename "${file}")"
    ffmpeg -i $file -map_metadata -1 -c:v copy -c:a copy "$(dirname "${file}")/R$(basename "${file}")" < /dev/null
done
