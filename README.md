# DOTFILES
Personal dotfiles repository. WIP.

<!--
# = GENERAL SETTINGS =
--ignore-errors
--no-abort-on-error
--no-continue
--force-overwrites
--no-mtime
--no-call-home
--geo-bypass
--no-check-certificate
--prefer-free-formats

# = PLAYLIST HANDLING =
--yes-playlist
--no-flat-playlist
--break-per-input

# = OUTPUT STRUCTURE =
# Artist / Album / XX. Title [id].opus
--output "%(artist,channel,uploader)s/%(album,playlist_title,snippet_title)s/%(playlist_index,track_number)s. %(title)s [%(id)s].%(ext)s"
--trim-filenames 220
--no-restrict-filenames

# = AUDIO EXTRACTION =
--extract-audio
--audio-format opus
--audio-quality 0
--embed-thumbnail
--embed-metadata
--add-metadata
--metadata-from-title "%(title)s"

# = POST-PROCESSING =
# Pass metadata and description/comment directly to FFmpeg
--ppa "Metadata+FFmpeg_o:-metadata description=%(description)s"
--ppa "Metadata+FFmpeg_o:-metadata comment=https://youtu.be/%(id)s"

# = THUMBNAIL HANDLING =
--convert-thumbnails png
--ppa "ThumbnailsConvertor+FFmpeg_o:-c:v png -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\""

# = METADATA MAPPING =
--parse-metadata "playlist_index:%(track_number)s"
--parse-metadata "uploader:%(artist)s"
--parse-metadata "artist:%(artist)s"
--parse-metadata "album:%(album)s"
--parse-metadata "album_artist:%(album_artist)s"
--parse-metadata "track:%(title)s"
--parse-metadata "release_year:%(release_year)s"
--parse-metadata "release_date:%(date)s"
--parse-metadata "composer:%(composer)s"
--parse-metadata "genre:%(genre)s"

# = STABILITY & RETRIES =
--retries infinite
--fragment-retries infinite
--concurrent-fragments 5
--sleep-interval 2
--max-sleep-interval 5

# = LOGGING / ARCHIVE =
--progress
--newline
--verbose
--write-info-json
# --download-archive downloaded.txt
 -->
