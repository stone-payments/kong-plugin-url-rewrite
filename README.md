# kong-plugin-url-rewrite

Kong API Gateway plugin for url-rewrite purposes. This plugin has been tested to work along with kong >= 3.x, for a legacy version of this plugin, please check [this link](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/legacy/v0).

## The Problem

When using Kong, you can create routes that proxy to an upstream. The problem lies when the upstream has a URL that is not very friendly to your clients, or RESTful, or even pretty. When you [add a Route in Kong](https://docs.konghq.com/gateway/latest/admin-api/#route-object), you have a [somewhat limited](https://docs.konghq.com/gateway/latest/key-concepts/routes/) URL rewrite capability. This plugin simply throws away the URL set in the Kong route and uses the URL set in its configuration to proxy to the upstream. This gives you full freedom over how to write your URLs in Kong and inner services as well.

## Configuration

| Parameter            | Required | Description                                                                                                                                                                                                 |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `config.url`         | yes      | The path used to rewrite the upstream URI. It **must start with a forward slash (`/`)** and may only contain characters from the RFC 3986 reserved list. Supports `<capture_name>` placeholders (see below). |
| `config.query_string` | no       | An array of `key=value` strings appended to the upstream query string. Values also support `<capture_name>` placeholders.                                                                                    |

### Placeholders

A `<capture_name>` placeholder is replaced at request time with the value of the
matching **named RegEx capture** from the route's path. For example, a route with
the path `~/foo/(?<bar>\S+)` exposes a `bar` capture that you can reference as
`<bar>` in `config.url` or `config.query_string`.

If the matched Kong service has a `path`, it is prepended to the rewritten URL.

### Enabling the plugin on a Route

With the Admin API:

```bash
curl -X POST http://kong:8001/routes/{route_id}/plugins \
    --data "name=url-rewrite" \
    --data "config.url=/new/path/<capture>"
```

- `route_id`: the id of the Route that this plugin configuration will target.

Declaratively (DB-less), as in [kong.yaml](kong.yaml):

```yaml
routes:
  - name: echo-route
    paths:
      - ~/foo/(?<bar>\S+)
    strip_path: false
    plugins:
      - name: url-rewrite
        config:
          url: /baz/<bar>
          query_string:
            - origin=foo
            - id=<bar>
```

A request to `/foo/123` is proxied upstream as `/baz/123?origin=foo&id=123`.

## Developing

A DB-less Kong (plus an echo upstream) is provided via Docker Compose for local
testing:

```bash
docker compose up --build
# then send requests through http://localhost:8000
```

Tests run with [Kong Pongo](https://github.com/Kong/kong-pongo) — see
[CONTRIBUTING.md](CONTRIBUTING.md) for the full workflow.

```bash
make test
```

## Credits

made with :heart: by Stone Payments
