![Build Status](https://stonepagamentos.visualstudio.com/_apis/public/build/definitions/3eb9c9ed-2656-4b52-ae5c-75ea4a42c98d/286/badge)

# kong-plugin-url-rewrite

This is a Kong middleware to log requests / responses using cerberus API.

# project structure

The plugin folder should contain at least a `schema.lua` and a `handler.lua`, alongside with a `spec` folder and a `.rockspec` file specifying the current version of the package.

# rockspec format

The `.rockspec` file should follow [LuaRocks' conventions](https://github.com/luarocks/luarocks/wiki/Rockspec-format)

# testing

We're using [busted](http://olivinelabs.com/busted) to run our tests. Every test file should live in a `spec` folder and end with `_spec.lua`.

## running the tests

`make test` or `busted spec/` in the plugin folder should do the job.

remember to run it as super user if your current environment needs it.

## test coverage

If you're using our Makefile, just run `make coverage`.

With Busted, a `-c` flag will do the job.
It will generate a `luacov.stats.out` that you can use to generate coverage reports.
You can run `luacov` and it will generate a `luacov.report.out` containing a comprehensive coverage report.

## lint

`make lint` or `luacheck -q .` in the plugin folder should run the linter.

# credits

made with :heart: by Stone Payments