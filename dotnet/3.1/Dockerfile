FROM		    mcr.microsoft.com/dotnet/sdk:3.1-bionic

MAINTAINER	Jonas Lateur <jonas@lateur.pro>

RUN			    apt-get update -y &&  apt-get install -y tar iproute2 tzdata && useradd -d /home/container -m container
ENV         TZ=Europe/Amsterdam

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ../entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
