# docker-anonymator


```
docker run -d -p 8118:8118 -p 9050:9050 -p 8123:8123 anonymator
curl --proxy localhost:8118 https://check.torproject.org/ | egrep -m 1 -o  "([0-9]{1,3}[\.]){3}[0-9]{1,3}" 
curl --socks5 localhost:9050 https://check.torproject.org/ | egrep -m 1 -o  "([0-9]{1,3}[\.]){3}[0-9]{1,3}" 
```

## Thanks

Based on https://github.com/simonpure/docker-tor-privoxy-alpine
