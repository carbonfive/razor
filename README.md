![alt tag](https://github.com/craiglyons/razor/blob/master/static/logo_tmp.jpg)

## Installing & running
* `mix escript.install https://github.com/carbonfive/razor/raw/master/razor_archives/razor`
* Add escript dir to your path or create a symlink, i.e. `ln -s /path/to/razor /usr/local/bin/`
* Run with `razor new YourAppName`
* Follow instructions to finish installation

If you want to install to a directory named differently from the app,
* `razor --name YourAppName --dir your_target_dir`

_Windows users - your executable may be `razor.bat` instead of `razor`

## Linting
* `mix credo --strict`

***

## Contributing
* Clone/fork Razor, make changes
* Add tests
* Bump the project version # in `mix.exs`
* `mix build_releases`
* Submit a PR
