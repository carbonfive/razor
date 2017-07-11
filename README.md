![alt tag](https://github.com/craiglyons/razor/blob/master/static/logo_tmp.jpg)

Phoenix application generator that builds a new project skeleton configured with Carbon Five preferences and best practices baked right in. Spend less time configuring and more building cool features.

Razor generates Phoenix projects by cloning a prototype app and massaging it gently into shape.

What's in the box?
- Phoenix
- Postgrex
- Slim
- Wallaby
- ExMachina
- Yarn
- Sass
- Bootstrap
- additional acceptance environment
- CI testing via CircleCI
- .iex.exs for REPL aliases & imports
- ready for deployment to Heroku Pipelines in acceptance and prod environments.

Inspired by [Carbon Five Raygun](https://github.com/carbonfive/raygun)

## Before You Start
You'll need the following dependencies:
* [Elixir 1.4.5](https://elixir-lang.org/install.html)
* [Yarn](https://github.com/yarnpkg/yarn) for JavaScript dependencies, installed and available on your path.
* [Brunch](https://github.com/brunch/brunch) for JavaScript builds, installed and available on your path.

## Installing & running
* `mix escript.install https://github.com/carbonfive/razor/raw/master/razor_archives/razor`
* Add the escript dir to your path or create a symlink, i.e. `ln -s /path/to/razor /usr/local/bin/`
* Run with `razor new YourAppName`
* Follow instructions to finish installation

If you want to install to a directory named differently from the app,
* `razor --name YourAppName --dir your_target_dir`

_Windows users - your executable may be `razor.bat` instead of `razor`_

## Next steps: deploying your new app, running locally, & c.

_See the prototype repository: [carbonfive/razor-phoenix](https://github.com/carbonfive/razor-phoenix) for more info_

## Linting
* `mix credo --strict`

## Internal Mechanics

Razor fetches the greatest tag from the carbonfive/razor-phoenix repo, unless it already has it cached in ~/.razor, extracts the contents of the tarball, and runs a series of search-and-replaces on the code to customize it accordingly.

This approach is fast, simple, and makes razor developement very easy. Make changes to the application prototype (which is a valid phoenix app) and tag them when they should be used for new applications.

***

## Contributing
* Clone/fork Razor, make changes
* Add tests
* Bump the project version # in `mix.exs`
* `mix compile; mix build_releases`
* Submit a PR
