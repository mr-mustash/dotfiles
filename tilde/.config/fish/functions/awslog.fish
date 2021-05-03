function awslog -d "Log into AWS CLI using Okta."
    set -x AWS_DEFAULT_REGION us-east-1
    set -x FORCE_MFA "Duo Push"
    set -l LOGIN_ROLE "database-administrator-rw"

    # account IDs (copied from the AWS Okta tile sign in, if you have more/others)
    set -l SAML2AWS_pelotoncycle 106877218800
    set -l SAML2AWS_prod 386675210126
    set -l SAML2AWS_stage 486598304777
    set -l SAML2AWS_test 152245890419
    set -l SAML2AWS_test_kitchen 048438595429
    set -l SAML2AWS_stage 429007243955


    set -l account_tuple (set -l | grep --color=never 'SAML2AWS_' | sed -e 's/SAML2AWS_//g' | eval "fzf $FZF_DEFAULT_OPTS -m --header='[AWS Accounts]'")
    set -l account_name (echo $account_tuple | awk '{print $1}')
    set -l account_number (echo $account_tuple | awk '{print $2}')

    echo -e "Logging in to account $account_name"

    set -l response (saml2aws login --skip-prompt --profile=$account_name --duo-mfa-option "Duo Push" --role="arn:aws:iam::$account_number:role/$LOGIN_ROLE")

    echo -e "\nSetting up environment variables for $account_name"

    # This is a hack as of Fish 3.1.2 because `eval (...)` does not work for
    # setting environmental variables.
    for line in (saml2aws script --shell=fish --skip-prompt --profile=$account_name)
        set -l name (echo $line | awk '{print $3}')
        set -l value (echo $line | awk '{print $4}')
        set -gx $name $value
    end
end
