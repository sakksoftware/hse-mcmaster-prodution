# HSE Frontend
Front end search

## Installation

1. Clone project
2. `cd` to project directory and install dependencies with `npm install && bower install`
3. :fire: up the app with `npm start`

## Usage

- `brunch watch --server` — watches the project with continuous rebuild. This will also launch HTTP server with [pushState](https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Manipulating_the_browser_history).
- `brunch build --production` — builds minified project for production
- `public/` dir is fully auto-generated and served by HTTP server.  Write your code in `app/` dir.
- Place static files you want to be copied from `app/assets/` to `public/`.

## Troubleshooting

### Deployment

If you deploy to heroku or do an `npm install` and get the following error:

```
npm ERR! code ELIFECYCLE
npm ERR! hse-frontend@0.0.1 postinstall: `gem install sass && bower install && brunch build --production`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the hse-frontend@0.0.1 postinstall script 'gem install sass && bower install && brunch build --production'.
npm ERR! This is most likely a problem with the hse-frontend package,
npm ERR! not with npm itself.
npm ERR! Tell the author that this fails on your system:
npm ERR!     gem install sass && bower install && brunch build --production
npm ERR! You can get their info via:
npm ERR!     npm owner ls hse-frontend
npm ERR! There is likely additional logging output above.
```

This probably means one of the scss or coffeescript files failed to compile. Check out and try running it locally again.