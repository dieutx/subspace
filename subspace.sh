#!/bin/bash

codeUrl=master

sudo apt update && sudo apt upgrade -y
sudo apt install curl htop build-essential git wget jq make gcc ack tmux ncdu -y
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.27.3/yq_linux_amd64 && chmod +x /usr/local/bin/yq
apt update && apt install git sudo unzip wget -y

if [[ $(which docker) && $(docker --version) ]]; then
    echo "Docker installed!"
    # command
  else
    echo "Installing docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

# #remove old nodes
# old1=$3
# old2=$4

# sleep 1

# for (( i=$old1; i <= $old2; ++i ))
# do
#   cd $HOME
# 	cd dnode$i
# 	docker compose down -v
# 	sleep 1
# 	cd $HOME
# 	rm -rf dnode$i
# done



#echo "Enter start numer (1,2,3,...): " 
#read startno

startno=$1

#echo "Enter end number (>= start no): " 
#read endno
endno=$2

sleep 1

for (( i=$startno; i <= $endno; ++i ))
do
  cd $HOME
	mkdir dnode$i
	cd dnode$i
	wget -O docker-compose.yaml https://raw.githubusercontent.com/owlstake/testnet/main/subspace/docker-compose.yaml
	wget -O .env https://bitbucket.org/dieuts/subspace/raw/$codeUrl/env/noded$i.txt
	sleep 1
	docker compose up -d
	sleep 1
done