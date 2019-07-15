FROM debian
MAINTAINER Remy Jette<remy@remyjette.com>

# Fetch dependencies, install DMD (D language) which OneDrive Free Client relies on,
# install the OneDrive Free Client, then remove some packages to slim down the image
RUN apt-get update \
 && apt-get -y install libcurl4-openssl-dev libsqlite3-dev wget gcc unzip make git \
 && wget http://downloads.dlang.org/releases/2.x/2.075.1/dmd_2.075.1-0_amd64.deb -O dmd.deb && dpkg -i dmd.deb \
 && git clone https://github.com/abraunegg/onedrive.git \
 && cd onedrive && git checkout v1.0.1 && make && make install \
 && apt-get remove -y wget gcc unzip make git \
 && apt-get autoremove -y

VOLUME ["/onedrive"]
 
RUN mkdir -p /root/.config/onedrive
RUN echo "sync_dir = \"/onedrive\"" > /root/.config/onedrive/config

ADD ./entrypoint.sh /

ENV SKIP_FILES=.*|~*

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/local/bin/onedrive", "-m"]
