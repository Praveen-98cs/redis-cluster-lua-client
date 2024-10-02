# File: Dockerfile
FROM --platform=linux/amd64 openresty/openresty:alpine-fat

# Install necessary packages
RUN apk add --no-cache git

# Install Lua modules
RUN luarocks install lua-resty-redis
RUN luarocks install lua-resty-lock
RUN luarocks install lua-cjson
RUN luarocks install lua-resty-redis-cluster

# Find the installation path of rediscluster.lua
RUN find / -name rediscluster.lua

# Copy NGINX config and Lua script
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY test.lua /usr/local/openresty/lualib/test.lua

EXPOSE 80

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
