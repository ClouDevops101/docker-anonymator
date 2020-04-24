FROM alpine
MAINTAINER Abdelilah Heddar <comment@blog.expertit.paris>

EXPOSE 8118 9050 8123 5353 9040

# Install tor and privoxy
RUN apk --no-cache --no-progress upgrade \
    && apk --no-cache --no-progress add bash curl privoxy shadow tini tor tzdata  runit openssl  build-base


RUN wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
		&& apk del build-base openssl 

#  Select the exit nodes country 

#echo 'ExitNodes {md},{lt},{kr},{jp},{id},{hk},{hr},{cn}' >>/etc/tor/torrc && \
#echo 'ExcludeNodes {us},{um},{fr},{ma}' >>/etc/tor/torrc && \
#echo 'ExcludeExitNodes {us},{um}' >>/etc/tor/torrc && \
RUN echo 'SocksPort 0.0.0.0:9050' >>/etc/tor/torrc && \
    echo 'EntryNodes {fr},{de}' >>/etc/tor/torrc && \
    echo 'ExitNodes {fr},{de}' >>/etc/tor/torrc && \
		echo 'DNSPort 5353' >>/etc/tor/torrc && \
		echo 'MaxCircuitDirtiness 700' >>/etc/tor/torrc && \
		echo 'StrictNodes 1' >>/etc/tor/torrc && \
		echo 'NewCircuitPeriod 300' >>/etc/tor/torrc && \
		echo 'OptimisticData 1' >>/etc/tor/torrc && \
		echo 'TransPort 9040' >>/etc/tor/torrc

COPY service /etc/service/

# Getting all uBlock config file into privoxy
RUN wget https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt -O /etc/service/privoxy/user.filter \
    &&  wget https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt -O ->> /etc/service/privoxy/user.filter \
    &&  wget https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt -O ->> /etc/service/privoxy/user.filter \
    &&  wget https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt -O ->> /etc/service/privoxy/user.filter

CMD ["runsvdir", "/etc/service"]