function fssh --wraps ssh -d "Start up my fish shell when sshing to a host"
    set -l host $argv

    ssh $host -t "mkdir -p /home/pking/.homedir && touch /home/pking/.homedir/fish_history && touch /home/pking/.homedir/fish_read_history ; sudo docker pull mrmustash/homedir:latest ; sudo docker run -it -e TERM=xterm-256color --net host --privileged --mount type=bind,source=/,destination=/home/pking/mounts/root -v /var/run/docker.sock:/var/run/docker.sock --mount type=bind,source=/home/pking/.homedir/fish_history,destination=/home/pking/.local/share/fish/fish_history --mount type=bind,source=/home/pking/.homedir/fish_read_history,destination=/home/pking/.local/share/fish/fish_read_history mrmustash/homedir:latest"
end
