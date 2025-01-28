function __fish_dirchanged_update_file_list --on-event dirchanged --description "Update the current file list on a directory change"
    set -g __dir_file_list (command ls -1a)
end
