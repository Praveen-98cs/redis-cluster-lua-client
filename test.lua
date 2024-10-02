-- File: test.lua
local redis_cluster = require "resty.rediscluster"

local redis_password = os.getenv("REDIS_PASSWORD") or "redis"

local config = {
    name = "testCluster",
    serv_list = {
        { ip = "redis-cluster.redis.svc.cluster.local", port = 6379 },
    },
    keepalive_timeout = 60000,
    keepalive_cons = 1000,
    connect_timeout = 1000,
    read_timeout = 1000,
    send_timeout = 1000,
    max_redirection = 5,
    max_connection_attempts = 1,
    auth = redis_password,
}

local red_c, err = redis_cluster:new(config)
if not red_c then
    ngx.log(ngx.ERR, "Failed to create redis cluster instance: ", err)
    return ngx.exit(500)
end

-- Set a key
local ok, err = red_c:set("foo", "bar")
if not ok then
    ngx.log(ngx.ERR, "Failed to set key: ", err)
    return ngx.exit(500)
end

-- Get the key
local res, err = red_c:get("foo")
if not res then
    ngx.log(ngx.ERR, "Failed to get key: ", err)
    return ngx.exit(500)
end

ngx.say("foo: ", res)
