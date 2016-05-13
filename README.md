# HSE Frontend
Front end search

## Installation

1. Clone project
2. `cd` to project directory and install dependencies with `npm install && bower install`
3. :fire: up the app with `npm start`

## Usage

run `npm start`

## Development

### Vagrant

A Vagrant config file is included in the project.
If Vagrant with VirtualBox provider are used on Windows host, to enable symlinks run Vagrant as Administrator.

1. `vagrant up` in the project directory to run and setup the virtual environment.
2. `vagrant ssh` or `ssh vagrant@localhost:2222` - Login to Vagrant virtual machine.
username: vagrant
password: vagrant

3. Inside the virtual machine `/vagrant` is the project directory
4. Go ahead with steps 2 and 3 of Installation section

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

Locale files are cached locally and managed by PhraseApp in the cloud by the client. Production pull directly from the API
allowing the client to modify things on their own. You can sync with the production files by using the PhraseApp CLI tool.

All translation are stored as a key-value pairs including some dynamic database content that is makred by the id
of items.

You can grab strings from the database for filters by copying and pasting the below code snippet in your browser
when you have the proper language selected. This is how the files in `locales/filtes/<language_name>.json` are generated.

    let FilterNormalizationService = require('services/filter_normalization_service');
    let SearchStore = require('stores/search_store');
    let filterTranslations = {filters: {}};

    let filters = FilterNormalizationService.getFiltersArray(SearchStore.state.search.filters);
    filters.forEach((f) => filterTranslations.filters[f.id] = f.title);
    copy(filterTranslations);

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
