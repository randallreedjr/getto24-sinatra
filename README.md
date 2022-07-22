Math24
======

Math 24 game and solver

This repository holds the source code for the math24 ruby gem.

math24 includes classes for both generating 24 Game problems as well as checking solutions. It also installs an executable, math24, that will allow the user to play a command line version of the 24 Game.

Ruby gem
--------
Installing the math24 gem should include all required dependencies.

For more information see:
[math24 at rubygems.org](https://rubygems.org/gems/math24)

Running the executable
----------------------
To run the command line game, first install the gem:
```bash
> gem install math24
Successfully installed math24-1.0.1
1 gem installed
```

Then, to start the game, type
```bash
> math24
```

To quit, just type
```bash
exit
```

## Deploying Web App

To launch the Web App locally, run:
```
web: bundle exec thin -R config.ru start
```
This should start the webserver at http://localhost:3000

The math 24 Sinatra web application is hosted on Heroku. Pushes to the `master` branch will automatically deploy via Codeship CI.

You can also force a deploy by running `git push heroku master`.

The web app is accessible at http://www.getto24.com.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
