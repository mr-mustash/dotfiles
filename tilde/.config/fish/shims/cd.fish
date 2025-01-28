function cd --wraps cd -d 'Emmit the dirchanged signal'
    builtin cd $argv
    emit dirchanged
end
