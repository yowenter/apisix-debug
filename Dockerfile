FROM apache/apisix:2.15.1-debian

#COPY client.lua /usr/local/apisix/apisix/core/dns/client.lua
#COPY utils.lua /usr/local/apisix/apisix/core/utils.lua
#COPY resolver.lua /usr/local/apisix/apisix/core/resolver.lua
COPY dns_client.lua /usr/local/apisix/deps/share/lua/5.1/resty/dns/client.lua

