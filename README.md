[![Build Status](https://travis-ci.org/stone-payments/kong-plugin-url-rewrite.svg?branch=master)](https://travis-ci.org/stone-payments/kong-plugin-url-rewrite)

# kong-plugin-url-rewrite

Kong API Gateway plugin for url-rewrite purposes.

# project structure

The plugin folder should contain at least a `schema.lua` and a `handler.lua`, alongside with a `spec` folder and a `.rockspec` file specifying the current version of the package.

# rockspec format

The `.rockspec` file should follow [LuaRocks' conventions](https://github.com/luarocks/luarocks/wiki/Rockspec-format)

## configuration

### enabling the plugin on a Route

Configure this plugin on a Route with:

```bash
curl -X POST http://kong:8001/routes/{route_id}/plugins \
    --data "name=kong-plugin-url-rewrite"  \
    --data "config.url=http://new-url.com"
```

- route_id: the id of the Route that this plugin configuration will target.

# credits

made with :heart: by Stone Payments
