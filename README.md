# Kong Plugin: JWT To Header (Route by JWT Claim)
![alt text](https://github.com/yesinteractive/kong-jwt2header/blob/master/banner-jwt2header.png "Kong Jwt2header plugin")

Update: Previously this plugin only worked with Kong Enterprise but has been updated to support both Kong community and enterprise as it uses the Kong commmunity JWT libraries.

This Kong Plugin can be used to route requests by JWT claim. It does this by converting JWT claims to headers during rewrite phase so 
that Kong's route by header functionality can be used to route the request appropriately. Alternatively, the plugin can be used to 
simply convert JWT claims to headers that can be consumed by the upstream service. 

Please note that this plugin does NOT validate JWT tokens. You will still need to use the proper Kong auth plugin (JWT, OIDC, etc.) to do so. 

## Installation

### luarocks

Verify Git is installed on your Kong Node then install via luarocks:

<pre>
$ luarocks install kong-plugin-jwt2header-1.0-1.all.rock
</pre>

Once installed, besure to include `kong-jwt2header` in your KONG_PLUGINS environment variable and reload Kong. 


## Configuration

Since this plugin has elements that must run in the Rewrite execution phase, this plugin can only be configured to run globally in a kong workspace or cluster.


| Parameter     | Default     | Description                                                              |  Required  |
| ------------- |-------------|--------------------------------------------------------------------------|-------------| 
| claims |  | The claims that you want to add to header                                | yes

