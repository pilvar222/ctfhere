# basically https://github.com/LiveOverflow/pwn_docker_example/blob/master/ctf/Dockerfile but with some cursed additions and QOL improvments
FROM ubuntu:22.04
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 && \
apt update && \
apt install -y build-essential jq strace ltrace curl wget rubygems gcc dnsutils netcat gcc-multilib net-tools nano gdb gdb-multiarch python3 python3-pip python3-dev python-is-python3 libssl-dev libffi-dev wget git make procps libpcre3-dev libdb-dev libxt-dev libxaw7-dev pip libc6:i386 libncurses5:i386 libstdc++6:i386 vim
RUN pip install capstone requests pwntools r2pipe
RUN pip install pwntools keystone-engine unicorn capstone roppeR
RUN mkdir tools && cd tools
RUN git clone https://github.com/JonathanSalwan/ROPgadget
RUN git clone https://github.com/radare/radare2 && cd radare2 && sys/install.sh
RUN cd .. && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh
RUN gem install one_gadget
RUN cd /tools/ && git clone https://github.com/NixOS/patchelf && cd patchelf && apt install autoconf -y && ./bootstrap.sh && ./configure && make && make check && make install
RUN cd /tools/ && wget https://github.com/io12/pwninit/releases/download/3.3.1/pwninit && chmod +x ./pwninit && mv ./pwninit /bin/pwninit
RUN apt install -y tmux screen
RUN apt install -y file ruby-dev
RUN gem install seccomp-tools
RUN pip install tqdm
RUN apt install -y python2.7
RUN apt install -y binwalk
RUN apt install -y hexedit
RUN apt install -y p7zip-full
RUN apt install -y elfutils
RUN apt install -y bsdmainutils
RUN pip install frida-tools
RUN apt install -y openssh-server
RUN mkdir -p /run/sshd
RUN printf 'export SHELL="/bin/bash"\nexport TERM="xterm-256color"\n' > /root/.bashrc
RUN cat /etc/skel/.bashrc >> /root/.bashrc
RUN  echo 'nohup bash -c "/usr/sbin/sshd -p 24889 -D" 2>/dev/null & sleep 0.1 && sed -i "/nohup bash -c/d" /root/.bashrc' >> /root/.bashrc
RUN mkdir -p /root/.ssh
RUN echo 'alias pwninit="pwninit --template-path /tools/pwninitTemplate.py"' >> /root/.bashrc
COPY pwninitTemplate.py /tools/pwninitTemplate.py
COPY id_rsa.pub /root/.ssh/authorized_keys
