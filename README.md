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
