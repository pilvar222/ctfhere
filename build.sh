#!/bin/bash
cp ~/.ssh/id_rsa.pub ./id_rsa.pub
echo "RUN groupadd --gid $(id | cut -d "(" -f2 | cut -d "=" -f2) $(whoami) && useradd --uid $(id | cut -d "(" -f1 | cut -d "=" -f2) --gid $(id | cut -d "(" -f2 | cut -d "=" -f2) -m $(whoami)" >> Dockerfile
echo "RUN echo 'nohup bash -c \"while true; do chown -R $(whoami):$(whoami) /mnt/ && sleep 0.1; done\" 2>/dev/null &' >> /root/.bashrc" >> Dockerfile
docker build -t ctf .
rm ./id_rsa.pub
sed -i '/alias alsoctf/d' ~/.bashrc
sed -i '/alias ctfhere/d' ~/.bashrc
echo "alias ctfhere=\"pwd | xargs printf -- 'docker run -p24889:24889 -it --name ctf -e HOST_UID=$(id -u) -e HOST_GID=$(id -g) --rm -v %s:/mnt ctf:latest /bin/bash' | xargs xargs -o\"" >> ~/.bashrc
echo "alias alsoctf=\"docker exec -it ctf /bin/bash\"" >> ~/.bashrc
source ~/.bashrc
