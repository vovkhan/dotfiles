function set_sub_file_paths()
    local video_filename = mp.get_property('filename/no-ext')
    local subs_dir = 'Subs/' .. video_filename  -- Folder matching the video filename
    local general_subs_dir = 'Subs'  -- General directory for all subtitles

    -- Check if the video-specific subdirectory exists and contains any subtitle files
    local cmd = "find '" .. subs_dir .. "' -type f -name '*.srt'"
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    if result ~= "" then
        -- If subtitle files are found in the specific subdirectory, use them
        mp.set_property('sub-file-paths', subs_dir)
    else
        -- If no subtitle files are found in the video-specific subdirectory, check the general directory
        cmd = "find '" .. general_subs_dir .. "' -type f -name '*.srt'"
        handle = io.popen(cmd)
        result = handle:read("*a")
        handle:close()

        if result ~= "" then
            -- If subtitle files are found in the general directory, use them
            mp.set_property('sub-file-paths', general_subs_dir)
        else
            -- If no subtitles are found at all, clear sub-file-paths (or set to default)
            mp.set_property('sub-file-paths', '')
        end
    end
end

mp.add_hook('on_load', 10, set_sub_file_paths)
