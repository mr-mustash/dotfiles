function __fish_prompt_languages -d "All of the language functions get called here in the order that I care about."
    __fish_prompt_language_docker
    __fish_prompt_language_fish
    __fish_prompt_language_golang
    __fish_prompt_language_terraform
    __fish_prompt_language_python
    __fish_prompt_language_vim
end
