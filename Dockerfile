FROM ubuntu:latest

RUN apt-get update && apt-get install -y sudo tini

ARG USERNAME=mattn
ARG GROUPNAME=mattn
ARG PASSWORD=user
RUN usermod -l mattn ubuntu && \
    groupmod -n mattn ubuntu && \
    usermod -d /home/mattn -m mattn && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN groupadd -g $GID $GROUPNAME && \
#    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
#RUN groupadd -g $GID $GROUPNAME && \
#    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
#    echo $USERNAME:$PASSWORD | chpasswd && \
#    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN apt-get update && apt-get install -y sudo nfs-common

USER $USERNAME
WORKDIR /home/$USERNAME/

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]
