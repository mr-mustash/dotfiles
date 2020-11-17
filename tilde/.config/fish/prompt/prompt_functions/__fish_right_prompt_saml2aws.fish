function __fish_right_prompt_saml2aws -d "Show the current AWS account selected with saml2aws."
    if ! set -q SAML2AWS_PROFILE
        return
    end
    [ -z "$AWS_PROMPT_ICON" ]; and set -l AWS_PROMPT_ICON ""


    echo -e (set_color $fish_prompt_color_aws)$AWS_PROMPT_ICON" "(set_color normal)"$SAML2AWS_PROFILE "
    # One day when annotations don't suck you can use this to display the full output of get-caller-identity
    #set -l message (aws sts get-caller-identity)
    #set -l length (string length $SAML2AWS_PROFILE)
    #echo -e (set_color $fish_prompt_color_aws)$AWS_PROMPT_ICON" "(set_color normal)"\x1b]1337;AddHiddenAnnotation=$length|$message\x07$SAML2AWS_PROFILE "
end
