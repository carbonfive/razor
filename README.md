![alt tag](https://github.com/craiglyons/razor/blob/master/static/logo_tmp.jpg)

## Installation
* Latest
  `mix archive.install https://github.com/carbonfive/razor/razor_archives/raw/master/razor.ez`
* Specific version
  `mix archive.install https://github.com/carbonfive/razor/razor_archives/raw/master/razor-x.x.x.ez`
  The list of all archives is available [https://github.com/carbonfive/razor/razor_archives/](here)
  
## Run
* `mix razor.new --name YourAppName --dir your_target_dir`
* Follow usage instructions

### Contributing 
## Cutting a new release

* Build a new release with your changes.  This will create a new release file in `razor_archives` with your version number, and overwrite the current `razor` release file.
  `MIX_ENV=prod VERSION=2.0.0 mix build`
* Push your release back up to github
