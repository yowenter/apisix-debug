--
-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

--- Domain Resolver.
--
-- @module core.resolver

local json = require("apisix.core.json")
local log = require("apisix.core.log")
local utils = require("apisix.core.utils")


local _M = {}


function _M.init_resolver(args)
    local dns_resolver = args and args["dns_resolver"]
    utils.set_resolver(dns_resolver)
    -- log.error("init dns resolver: ", json.delay_encode(dns_resolver, true))
end

---
--  Resolve domain name to ip.
--
-- @function core.resolver.parse_domain
-- @tparam string host Domain name that need to be resolved.
-- @treturn string The IP of the domain name after being resolved.
-- @usage
-- local ip, err = core.resolver.parse_domain("apache.org") -- "198.18.10.114"
function _M.parse_domain(host)
    local ip_info, err = utils.dns_parse(host)
    if not ip_info then
        log.error("failed to parse domain: ", host, ", error: ",err)
        return nil, err
    end

  --  log.error("host: ", host, " parse addr: ", json.delay_encode(ip_info))
    -- log.error("resolver: ", json.delay_encode(utils.get_resolver()))
    if ip_info.address then
        log.info("dns resolver domain: ", host, " to ", ip_info.address)
        return ip_info.address
    end
    log.error("host: ", host, "!!!!! ip_info no address: ", json.delay_encode(ip_info, true), "resolver: ", json.delay_encode(utils.get_resolver(), true) )

    return nil, "failed to parse domain"
end


return _M

