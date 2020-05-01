function fssh --wraps ssh -d "Start up my fish shell when sshing to a host"
    set -l host $argv

    ssh $host -t "sudo docker pull mrmustash/homedir:latest ; sudo docker run -it -e TERM=xterm-256color --net host --privileged --mount type=bind,source=/,destination=/home/pking/mounts/root -v /var/run/docker.sock:/var/run/docker.sock -v /home/pking/.homedir/fish_history:/home/pking/.local/share/fish/fish_history mrmustash/homedir:latest"
end
