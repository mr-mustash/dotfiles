set -x  fish_color_autosuggestion 555
set -x  fish_color_command 005fd7
set -x  fish_color_comment 990000
set -x  fish_color_cwd green
set -x  fish_color_cwd_root red
set -x  fish_color_end 009900
set -x  fish_color_error ff0000
set -x  fish_color_escape bryellow\x1e\x2d\x2dbold
set -x  fish_color_history_current \x2d\x2dbold
set -x  fish_color_host normal
set -x  fish_color_match \x2d\x2dbackground\x3dbrblue
set -x  fish_color_normal normal
set -x  fish_color_operator bryellow
set -x  fish_color_param 00afff
set -x  fish_color_quote 999900
set -x  fish_color_redirection 00afff
set -x  fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -x  fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -x  fish_color_user brgreen
set -x  fish_color_valid_path \x2d\x2dunderline
set -x  fish_greeting \x1d
set -x  fish_pager_color_completion \x1d
set -x  fish_pager_color_description B3A06D\x1eyellow
set -x  fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -x  fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

# Setting iTerm tab color based on environment
# https://www.iterm2.com/documentation-escape-codes.html
set uname (uname)
#set ecosystem (cat /nail/etc/ecosystem)
set short_host (hostname -s)
function iterm2_print_user_vars
    # Reset Terminal for localhost
    if test $uname = 'Darwin'
        echo -e "\033]6;1;bg;*;default\a" | tr -d '\n'
    end

    # First test to see if we're connected to a linux machine
    if test $uname = 'Linux'
        # Next use $ecosystem to figure out where we are
        # (These Colors based on Solarized)
        switch $ecosystem
            case dev devc # Green
                echo -e "\033]6;1;bg;red;brightness;103\a" | tr -d '\n'
                echo -e "\033]6;1;bg;green;brightness;137\a" | tr -d '\n'
                echo -e "\033]6;1;bg;blue;brightness;30\a" | tr -d '\n'
            case stagef stageg stage # Blue
                echo -e "\033]6;1;bg;red;brightness;44\a" | tr -d '\n'
                echo -e "\033]6;1;bg;green;brightness;129\a" | tr -d '\n'
                echo -e "\033]6;1;bg;blue;brightness;168\a" | tr -d '\n'
            case prod # Red
                echo -e "\033]6;1;bg;red;brightness;172\a" | tr -d '\n'
                echo -e "\033]6;1;bg;green;brightness;47\a" | tr -d '\n'
                echo -e "\033]6;1;bg;blue;brightness;53\a" | tr -d '\n'
            case '*' #Magenta
                echo -e "\033]6;1;bg;red;brightness;211\a" | tr -d '\n'
                echo -e "\033]6;1;bg;green;brightness;54\a" | tr -d '\n'
                echo -e "\033]6;1;bg;blue;brightness;130\a" | tr -d '\n'
        end
    end

    # Always display short hostname in wondow title.
    function fish_title
        echo $short_host
    end

end
