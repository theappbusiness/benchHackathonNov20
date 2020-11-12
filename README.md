# benchHackathonNov20

## Mock-Server

### Installing json-server
We are currently using `json-server` as a mock server to run the project against.

In order to get up and running you will need to install `json-server`, if you don't already have it installed you can do this from the command line by running the following command:

```
npm install -g json-server
```

### Running the json-server

and can spin up the server by navigating to:
`/shared/src`

and then running the line below to spin up the server locally:

```
json-server --watch db.json
```

### Simulator settings for localhost

In order for the app to access the server from Android simulator, we need to adjust the endpoint declared i the companion object in. (line 31 or 34) 

`commonMain/kotlin/.../network/MealApi`


