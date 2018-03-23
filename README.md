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

You'll need these dependencies for Razor & your new Phoenix app:

- Erlang
- [Elixir 1.6](https://elixir-lang.org/install.html)
- Postgres
- [Yarn](https://github.com/yarnpkg/yarn) for JavaScript dependencies, installed and available on your path.
- [Phantomjs](https://github.com/ariya/phantomjs) for feature tests, installed and available on your path.

_Note for [asdf](https://github.com/asdf-vm/asdf) users - both Razor & the generated app have a `.tool-versions` file to help you get the right versions of things. You can change these - for example, erlang 19.3 is probably fine, but currently has installation problems on Macs._

## Installing & running

- `mix escript.install https://github.com/carbonfive/razor/raw/master/razor_archives/razor`
- Add the escript dir to your path or create a symlink, i.e. `ln -s /path/to/razor /usr/local/bin/`
- Cut your app with `razor new YourAppName`
- Or, if you want to install to a directory named differently from the app,
- `razor new YourAppName your_target_dir`


## Build your new project

1. `cd your_new_project_dir`
1. `mix deps.get` - install dependencies
1. `mix ecto.setup` - setup your local database
1. Prep js - `cd assets; yarn install; ./node_modules/.bin/brunch build`
1. Verify the test suite passes with `mix test`
1. Generate a secret key base with `mix phx.gen.secret`. You'll use this in the next step when you run your server.
1. Run your server with `MIX_ENV=dev SECRET_KEY_BASE= mix phx.server`. Use the key you just generated as the value for `SECRET_KEY_BASE`.
1. That's it! Visit your fully-featured app at `127.0.0.1:4000`.

_Windows users - your executable may be `razor.bat` instead of `razor`_

## Configure your development environment (optional)

Rather than inlining the environment variables while running the server in development, we recommend using a tool that works with Procfile / `.env` configs.
[Heroku Local](https://devcenter.heroku.com/articles/heroku-local) and [Foreman](https://github.com/ddollar/foreman) are both good options.

A simple Procfile is provided for you. Create a `.env` file in your project directory with these environment variables:

```txt
MIX_ENV=dev
SECRET_KEY_BASE=xxxxxx
```

You can now run your server using the tool of choice, i.e. `heroku local`.

As a convenience, a weak `SECRET_KEY_BASE` is hard-coded in the `test` environment. You can easily change this to read an env var a la the other environments instead if needed.

## Deployment

Your app is pre-configured for easy deployment to Heroku w/ pipelines using CircleCI.  CI is only used to run tests; your pipelines should be configured to auto-deploy branches after passing CI tests.

Convention is to auto-deploy `master` branch to `acceptance`, and `production` branch to `production`.

- Create Heroku apps for `acceptance` and `production`
- Provision Heroku Postgres DB resources
- Add buildpacks to Heroku apps
  - `heroku buildpacks:add https://github.com/HashNuke/heroku-buildpack-elixir.git --app your-heroku-app-name`
  - `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git --app your-heroku-app-name`
- Add environment variables to Heroku
  - `SECRET_KEY_BASE`, which can be generated with the task `mix phx.gen.secret`
  - `MIX_ENV` should be `prod`
  - `HOSTNAME`, should be the hostname of the deployed site (e.g. `app-prototype-production.herokuapp.com` on production environments, or `app-prototype-acceptance.herokuapp.com` for acceptance environments)
  - `POOL_SIZE` should be set 2 units below the max db connections allowed by the Heroku instance. This allows mix tasks to be run with 2 connections.
  - `DATABASE_URL` should have been filled automatically by provisioning heroku postgres.

## Linting

- `mix credo --strict`

## Internal Mechanics

Razor fetches the latest tag from the carbonfive/razor-phoenix repo, unless it already has it cached in ~/.razor, extracts the contents of the tarball, and runs a series of search-and-replaces on the code to customize it accordingly.

This approach is fast, simple, and makes razor development very easy. Make changes to the application prototype (which is a valid phoenix app) and tag them when they should be used for new applications.

***

## Contributing to Razor

- Clone/fork Razor, make your changes & add tests
- Bump the project version # in `mix.exs`
- `mix compile; mix build_releases`
- Submit a PR
