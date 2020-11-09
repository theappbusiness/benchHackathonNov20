# benchHackathonNov20

## Server Setup

We are currently using `json-server` as a mock server to run the project against.

In order to get up and running you will need to install `json-server`, if you don't already have it installed you can do this from the command line by running the following command:

```
npm install -g json-server
```

### Running the Server
Once installed you can spin up the server by running the shortcut script by entering from the root directory :

```
./start-server.sh
```

Or manually by navigating to:
`/shared/src`

and then running the line below to spin up the server locally:

```
json-server --watch db.json
```

### Editing the default values of the server.

To make a change to the mock database you will need to edit this file:

`/shared/src/db.json`