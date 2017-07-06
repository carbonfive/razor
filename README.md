![alt tag](https://github.com/craiglyons/razor/blob/master/static/logo_tmp.jpg)

## Installing
* `mix escript.install https://github.com/carbonfive/razor/raw/master/razor_archives/razor.ez`
* Add razor to your path as suggested (or fully-qualify `razor` when running)

## Running
* `razor new YourAppName`
* Follow usage instructions

If you want to install to a directory named differently from the app,
* `razor --name YourAppName --dir your_target_dir`

_Windows users - your executable may be `razor.bat` instead of `razor`_

## Linting
* `mix credo --strict`

***

## Contributing
* Clone/fork Razor, make changes
* Add tests
* Bump the project version # in `mix.exs`
* `mix build_releases`
* Submit a PR
