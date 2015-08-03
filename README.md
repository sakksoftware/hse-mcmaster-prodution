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

For deployment we use a `koa` server on heroku. It will eventually be integrated to a .NET project.

If you want to try it out run: `node --harmony server.js`.

username: hse
password: withgreatpower

## API END POINTS

All requests are preceded with `/api/` omitted here for brevity.

* `GET /search`
  returns search results in a json format as shown here](https://hse-frontend.herokuapp.com/fake_api/search.json).

  params:
  * `q` - search query
  * `filters` - semi-colon separated list of IDs of the applied filters  
  * `sort_by` - order of search results
  * `page` - the result page to be returned
  * `lang` - the language in which the search is to be performed


* `GET /search/suggestions`
    returns suggestions for autocomplete controls in a json format [as shown here](https://hse-frontend.herokuapp.com/fake_api/search/suggestions.json).

    params:

    * `q` - search query
    * `lang` - the language in which the search is to be performed


* `GET /documents/:id`
    returns the requested document in a json format [as shown here](https://hse-frontend.herokuapp.com/fake_api/documents/0df62f0040ffd8ecd725c9a602056034.json).

    params:
    * `lang` - the language the results should be in


* `GET /questions/`
    returns a list of guide questions and their results.

    params:
    * `lang` - the language the results should be in


* `GET /user`
    returns information about the currently signed up user.

    params:
    `lang` - the language the results should be in


* `UPDATE /users/:id
    allows user details to be updated

* `GET /user/profile`
    return the user profile information for the currently signed in user.

    params:
    * `lang` - the language the results should be in


* `POST /user/login`
    allows user to signin into the service.

    params:
    * `username` - the chosen username
    * `password` - the chosen password


* `POST /users`
    create a new user (as a result from a user sign up)

    params:
    * `email` - user email
    * `password` - user password


* `GET /user/searches`
    return of saved searches for the currently logged in user

* `POST /user/searches/`
    creates a new saved search for the currently logged in user

* `GET /user/documetns`
    returns a list of saved documents for the currently logged in user

* `POST /user/documents`
    creates a new saved document

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

`app/styles/components/search/guide_question.scss compiled, but not written. Check your stylesheets.joinTo config.`

This warning will appear during compile time. We still don't know how to get rid of those. If you do, please do!
