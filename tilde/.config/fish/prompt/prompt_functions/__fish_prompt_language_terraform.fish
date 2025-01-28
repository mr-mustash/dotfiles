function __fish_prompt_language_terraform -d "Display vim version"
    if not string match -q "*.hcl" $__dir_file_list; or not string match -q "*.tf" $__dir_file_list
        return 0
    end

    if ! set -q tf_version; or ! set -q tg_version
        set -gx tf_version (terraform -v | head -n 1 | cut -d ' ' -f 2)
        set -gx tg_version (terragrunt -v | head -n 1 | cut -d ' ' -f 3)
        set -gx tg_version "v$tg_version"
    end

    if string match -q "*.hcl" $__dir_file_list
        # Show terragrunt version of HCL is in file
        set -x tgtf_version $tg_version
    else
        set -x tgtf_version $tf_version
    end

    echo -ns (set_color $fish_prompt_color_terraform_icon) " " (set_color normal)
    echo -ns (set_color --bold) " $tgtf_version" (set_color normal)
end
