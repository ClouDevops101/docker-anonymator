<a href="http://bitly.com/2grT54q"><img src="https://cdn.codementor.io/badges/i_am_a_codementor_dark.svg" alt="I am a codementor" style="max-width:100%"/></a><a href="http://bitly.com/2grT54q">
 [![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WX4EKLLLV49WG)
# docker-anonymator
![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Tor-logo-2011-flat.svg/612px-Tor-logo-2011-flat.svg.png)
![](https://www.alpinelinux.org/alpinelinux-logo.svg)

```
docker run -d -p 8118:8118 -p 9050:9050 -p 8123:8123 anonymator

curl --proxy localhost:8118 https://check.torproject.org/ | egrep -m 1 -o  "([0-9]{1,3}[\.]){3}[0-9]{1,3}" 
curl --socks5 localhost:9050 https://check.torproject.org/ | egrep -m 1 -o  "([0-9]{1,3}[\.]){3}[0-9]{1,3}" 
```
## Some useful stuff

```
while true 
   do  
       ip=`curl -s --socks5 localhost:9050 https://check.torproject.org | egrep -m 1 -o  "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`
       whois $ip | grep country
       echo $ip
       sleep 10

   done
...
country:        GB
185.0.4.X
```

## Thanks

Based on https://github.com/simonpure/docker-tor-privoxy-alpine
