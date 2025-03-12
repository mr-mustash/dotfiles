function __fish_on_variable_pwd --on-variable PWD --description "Recalculate dir string when directory changes"
    set -e __fish_prompt_pwd_string
end
