#!/bin/bash
cp ~/.ssh/id_rsa.pub ./id_rsa.pub
docker build -t ctf .
rm ./id_rsa.pub
sed -i '/alias alsoctf/d' ~/.bashrc
sed -i '/alias ctfhere/d' ~/.bashrc
echo "alias ctfhere=\"echo \\\"\\\$(id -u) \\\$(id -g) \\\$(pwd)\\\" | xargs printf -- 'docker run -p24889:24889 -it --name ctf -e HOST_UID=%s -e HOST_GID=%s --rm -v %s:/mnt ctf:latest /bin/bash' | xargs xargs -o\"" >> ~/.bashrc
echo "alias alsoctf=\"docker exec -it ctf /bin/bash\"" >> ~/.bashrc
source ~/.bashrc
