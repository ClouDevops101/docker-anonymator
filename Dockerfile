FROM alpine:edge

EXPOSE 8118 9050 8123 5353 9040

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' \
    >> /etc/apk/repositories \
    && apk add --no-cache --update  build-base openssl privoxy tor@testing runit@testing \
    && wget https://github.com/jech/polipo/archive/master.zip -O polipo.zip \
    && unzip polipo.zip \
    && cd polipo-master \
    && make \
    && install polipo /usr/local/bin/ \
    && cd .. \
    && rm -rf polipo.zip polipo-master \
    && mkdir -p /usr/share/polipo/www /var/cache/polipo \
		&& apk del build-base openssl

RUN echo 'SocksPort 0.0.0.0:9050' >>/etc/tor/torrc && \
		echo 'DNSPort 5353' >>/etc/tor/torrc && \
		echo 'EntryNodes {pl},{gb},{au},{br},{cg},{cd},{cn}' >>/etc/tor/torrc && \
                echo 'ExitNodes {pl},{gb},{au},{br},{cg},{cd},{cn}' >>/etc/tor/torrc && \
		echo 'ExcludeNodes {us},{um},{de},{fr}' >>/etc/tor/torrc && \
		echo 'StrictNodes 1' >>/etc/tor/torrc && \
		echo 'ExcludeExitNodes {us},{um},{de},{fr}' >>/etc/tor/torrc && \
		echo 'NewCircuitPeriod 60' >>/etc/tor/torrc && \
		echo 'TransPort 9040' >>/etc/tor/torrc

COPY service /etc/service/

CMD ["runsvdir", "/etc/service"]
