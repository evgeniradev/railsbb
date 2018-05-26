# RailsBB

A Rails-based bulletin board.

## Installation

Please, use [Docker](https://docs.docker.com/) to install the app.

Run the below setup command to build the containers, create a new database and run the migrations. Please note, the command drops any existing database.
```
$ ./setup.sh
```

Start the app in development mode:
```
$ ./start.sh
```

An admin account with the following log-in details will be created for you:

email: **admin@admin.com**\
password: **123456**

Finally, load [http://localhost](http://localhost) in your browser.


## Running the tests

```
$ ./test.sh
```

## To-do list

* Make design responsive
* Improve and finish off tests
* Refactor(Move some logic to Service objects)
* Implement Admin dashboard
* Implement access control(banned IPs)
* Add a public page that lists all users
* Refactor TopicsController
* Add search engine to admin/users
* Improve warning messages when deleting sections and forums
