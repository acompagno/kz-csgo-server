FROM acompagno/sm-csgo-server

USER root

RUN apt-get -y update \
        && apt-get -y upgrade \
        && apt-get install -y unzip wget \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

USER $USER

# download and install kztimer 
RUN wget -O $DOWNLOAD_DIR/kztimer.zip https://bitbucket.org/kztimerglobalteam/kztimerglobal/downloads/1.89_Full.zip 
RUN unzip -o -d $CSGO_DIR $DOWNLOAD_DIR/kztimer.zip

# set up database for KZTimer mod (from: http://www.kz-climb.com/index.php?threads/tutorial-local-kztimer-server.470/)
RUN rm $CSGO_DIR/addons/sourcemod/configs/databases.cfg
ADD ./kz_databases.cfg $CSGO_DIR/addons/sourcemod/configs/databases.cfg

# kz server config (from http://www.kz-climb.com/index.php?threads/tutorial-local-kztimer-server.470/)
ADD ./kz_server.cfg $CSGO_DIR/cfg/server.cfg