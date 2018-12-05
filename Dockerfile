FROM resin/armv7hf-debian

RUN [ "cross-build-start" ]

RUN curl https://archive.raspbian.org/raspbian.public.key  | sudo apt-key add - && echo "deb-src http://archive.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list && apt-get update && mkdir ~/unrar-nonfree && cd ~/unrar-nonfree && apt-get build-dep unrar-nonfree && apt-get source -b unrar-nonfree && dpkg -i unrar*.deb && cd && rm -r ~/unrar-nonfree  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install sabnzbdplus python-openssl p7zip-full unzip par2 python-yenc && rm -rf /var/lib/apt/lists/*

VOLUME /data
VOLUME /config

EXPOSE 8080

RUN [ "cross-build-stop" ]
CMD /usr/bin/sabnzbdplus -f /config/sabnzbd.ini -s 0.0.0.0:8080 -b 0
