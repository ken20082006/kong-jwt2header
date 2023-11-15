# Kong Plugin: JWT To Header 
This is a kong plugin for extract claims from JWT to the header.

## Installation

### pack the plugin
With luarocks(3.9.2) and lua(>5.1)

execute the below command

```
luarocks make kong-jwt2header-1.0-1.rockspec
luarocks pack kong-jwt2header 1.0-1
```

#### use Docker
This repo contain a lua container for you to pack the plugin yourself. 
Follow the below step:

Start the container:
```
docker compose up -d
```

Pack the plugin using the container:
```
docker exec -it [CONTAINER_NAME] luarocks make kong-jwt2header-1.0-1.rockspec
docker exec -it [CONTAINER_NAME] luarocks pack kong-jwt2header 1.0-1

docker cp [CONTAINER_NAME]:/tmp/volume/kong-jwt2header-1.0-1.all.rock kong-jwt2header-1.0-1.all.rock
```
You will have the packed plugin file `kong-jwt2header-1.0-1.all.rock`

### luarocks

Verify Git is installed on your Kong Node then install via luarocks:

<pre>
$ luarocks install kong-plugin-jwt2header-1.0-1.all.rock
</pre>

Once installed, besure to include `kong-jwt2header` in your KONG_PLUGINS environment variable and reload Kong. 

## Using the plugin
```
curl -X POST http://localhost:8001/services/{serviceName|Id}/plugins \
    --data "name=kong-jwt2header"  \
    --data "config.claims=sub,aud"
```
After added the plugin, new headers with prefix `X-Kong-JWT-Claim-` will be added.
ie. `X-Kong-JWT-Claim-sub` and `X-Kong-JWT-Claim-aud`

## Configuration

Since this plugin has elements that must run in the Rewrite execution phase, this plugin can only be configured to run globally in a kong workspace or cluster.


| Parameter | Default | Description                                                | Required |
|-----------|---------|------------------------------------------------------------|----------| 
| claims    |         | The claims that you want to add to header, comma separated | yes      |

