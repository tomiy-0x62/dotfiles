function fish_prompt --description 'Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                         and set_color $fish_color_cwd_root
                                                         or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        set  separator_triangle \uE0B0
        set segment_separator $separator_triangle
        set  host_color E35459

        function _segment
            set_color -b $argv[1] $argv[2]
        end

        set white D0D0D0
        set glay 292C34
        set light_glay 3B4048
        set white2 B1B8C5
        set sky 61AFEF
        set pwhite FFFFFF
        set blue 7F9CFE
        set light_blue 63F8F8
        set pink FF517D

        echo ""

        # Data
        set_color $blue
        printf  "[%s]\n" (date "+%H:%M:%S")

        # SSH status
        set -l ssh_client (set | grep ^SSH_CLIENT)
        if string length -q -- $ssh_client
            _segment $light_glay $pink
            echo -n ' [ssh] '
            _segment $host_color $light_glay
            echo -n "$segment_separator "
        end

        # host indicator
        set_color -b $host_color
        echo -n " "
        _segment $white $host_color
        echo -n "$segment_separator "

        # host name
        set_color $glay
        printf "@%s " (prompt_hostname)
        _segment $light_glay $white
        echo -n "$segment_separator "

        # user name
        set_color $white2
        printf "%s " $USER
        _segment $sky $light_glay
        echo -n "$segment_separator "

        # pwd
        set_color $pwhite
        printf "%s " (string replace -a $HOME \~ (pwd))
        _segment normal $sky
        echo -n "$segment_separator "
        set_color normal

        # git
        set -l icon_octocat \uF113
        _segment normal white
        printf '%s' (fish_git_prompt "( $icon_octocat  %s )")
        set_color normal


        # last cmd status & arrow
        printf '\n%s' $pipestatus_string
        set_color $light_blue
        printf '→ '

        # printf '\n[%s]\n \uE0B0 %s@%s \uE0B0 %s \uE0B0 %s%s \uE0B0 \n%s%s→ ' (date "+%H:%M:%S") (set_color brblue) \
            # (prompt_hostname) $USER (set_color $fish_color_cwd) $PWD $pipestatus_string \
            # (set_color normal)
    end
end
