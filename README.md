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

## Deployment

For deployment we use an `express` server on heroku.

If you want to try it out run: `node server.js`.

To deploy to both PHCPI & HSE McMaster simply run the deploy task, it will warn you about any merge conflicts.

```
./deploy
```

### Staging

username: hse
password: withgreatpower

### PHCPI

To create a custom version for PHCPI we created a separte branch and a new app. Make sure to merge all
changes into that branch and deploy to the app using the following command:

    git push phcpi phcpi:master

## API END POINTS

See wiki page for [API documentation](https://github.com/func-i/hse-frontend/wiki/API-End-Points)

## Localization

Locale files live on s3 and used by translators, however there is a local copy for development and it will need to be synced withgreatpower
the remote copy.

First download the locales:

```
cd locales/
aws s3 sync s3://my-hse-staging/locales/hse .
```

Then upload them

```
aws s3 sync . s3://my-hse-staging/locales/hse
```

NOTE: please upload the S3 files to the proper folder based on the branch you are on.
For master it will be uploaded to hse, and for phcpi to phcpi. The reason we elected
not to use this file structure locally is so we can more easily merge text changes
from master to phcpi when adding new features to hse.

## Troubleshooting

### Deployment Issues

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

## Known Issues
