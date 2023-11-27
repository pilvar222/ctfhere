FROM ubuntu:23.10
ENV LC_CTYPE C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y build-essential jq strace ltrace curl wget rubygems gcc dnsutils netcat-traditional gcc-multilib net-tools nano gdb gdb-multiarch python3 python3-pip python3-dev python-is-python3 libssl-dev libffi-dev wget git make procps libpcre3-dev libdb-dev libxt-dev libxaw7-dev pip libc6:i386 libstdc++6:i386 vim
RUN pip3 install capstone requests pwntools r2pipe --break-system-packages
RUN pip3 install pwntools keystone-engine unicorn capstone ropper --break-system-packages
RUN mkdir tools && cd tools &&  \
git clone https://github.com/JonathanSalwan/ROPgadget && \
git clone https://github.com/radare/radare2 && cd radare2 && sys/install.sh && \
cd .. && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh && \
gem install one_gadget
RUN cd /tools/ && git clone https://github.com/NixOS/patchelf && cd patchelf && apt install autoconf -y && ./bootstrap.sh && ./configure && make && make check && make install
RUN cd /tools/ && wget https://github.com/io12/pwninit/releases/download/3.3.0/pwninit && chmod +x ./pwninit && mv ./pwninit /bin/pwninit
RUN apt install -y tmux screen
RUN apt install -y file ruby-dev
RUN gem install seccomp-tools
RUN apt install -y binwalk
RUN apt install -y hexedit
RUN apt install -y p7zip-full
RUN pip install frida-tools --break-system-packages
RUN apt install -y elfutils
RUN apt install -y bsdmainutils
