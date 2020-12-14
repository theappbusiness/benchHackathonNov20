# benchHackathonNov20
This project is focused around developing both an iOS and Android app, using KMM for the shared logic between both platforms.

## The concept
"CommunityKitchen" is a platform to donate and find excess food for those in need that would otherwise go to waste. 
Currently, a user can: create an account and login and search for meals in their local area. 

## Prerequisites

### Android Studio
Version 4.2 > is required to compile this project. From the latest changes, Arctic Fox (Canary 2, Beta) is required due to using Compose.

### Xcode
For running the iOS app via Xcode and for using the simulator, version 12.1 > is required.

### Google Maps Api
To use the location services and to view the available meals on the map, you will need to add the api key to your project.

### Firebase Console
We're using Firebse for authentication purposes - for viewing this data and making changes you'll need access to it. 

### Please message one of us about either of these and we will send details over if you need access ^ ###

### Mock-Server
We are currently using `json-server` as a mock server to run the project against. 
This is required to display and post the meal data.

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
