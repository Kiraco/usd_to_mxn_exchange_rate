# usd_to_mxn_exchange_rate

## Required programs

- go
- flutter
- dart
- docker

## Running go backend

To start the backend, run the following command in the root folder of `data-collector` go project

`docker build -t data-collector .`

This will build the `data-collector` docker image with the same name. To run the image run the command

`docker run -d -p 3000:3000 data-collector`

## Running front-end

To start the backend, run the following command in the root folder of `usd_to_mxn_exchange_rate` dart project

`docker build . -t usd_to_mxn`

This will build the `usd_to_mxn` docker image with the same name. To run the image run the commands

`docker run -p 8443:8443 -p 8080:8080 -it usd_to_mxn bash`
`webdev serve --hostname=0.0.0.0`

and in the browser go to

`127.0.0.0:8080`

If want to run without docker, flutter and dart needs to be installed. For installation follow the steps in the link https://flutter.dev/docs/get-started/install/

Once flutter is installed, go to `usd_to_mxn_exchange_rate` root folder and run the command

`webdev start --auto restart`

then open a browser with CORS disabled, either chrome, firefox, ect.

MacOS command example is

`/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security`

This will allow communication for local development. from back and frond end

To see the app running go to `http://localhost:8080/`
