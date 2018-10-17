#FROM alpine:edge
FROM alpine:latest

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

CMD ["runsvdir", "/etc/service"]
