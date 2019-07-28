# FROM ubuntu:14.10
FROM    ubuntu:18.04

COPY    ./entrypoint.sh /

RUN     rm /etc/dpkg/dpkg.cfg.d/excludes && \
        apt-get update && \
        apt-get upgrade && \
        apt-get install -y vim && \
        apt-get install -y git && \
        apt-get install -y make && \
        apt-get install -y gcc && \
        apt-get install -y man && \
        apt-get install -y strace && \
        dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall && \
        rm -r /var/lib/apt/lists/*

ENTRYPOINT [ "/entrypoint.sh" ]

# docker build --tag ft_strace .
# docker run -it --name strace_devenv --rm --security-opt seccomp:unconfined -v ~/Documents/strace:/strace ft_strace

# Details :
# - rm /etc/dpkg/dpkg.cfg.d/excludes => Do not exclude man pages & other documentation
# - dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall && rm -r /var/lib/apt/lists/* => reinstall all to have all the mans
# - security-opt seccomp:unconfined : to disabled security feature in container and execute strace (dev mode only !)
# -v ~/Documents/strace:/strace ft_strace => bind mount with de -v syntax
