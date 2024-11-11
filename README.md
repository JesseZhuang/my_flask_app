# GitHub Codespaces ♥️ Flask

Welcome to your shiny new Codespace running Flask! We've got everything fired up and running for you to explore Flask.

You've got a blank canvas to work on from a git perspective as well. There's a single initial commit with the what you're seeing right now - where you go from here is up to you!

Everything you do here is contained within this one codespace. There is no repository on GitHub yet. If and when you’re ready you can click "Publish Branch" and we’ll create your repository and push up your project. If you were just exploring then and have no further need for this code then you can simply delete your codespace and it's gone forever.

To run this application:

```
cd circle
flask --debug run

flask --app flaskr run --debug
```

```
python3 -m venv circle_env
cd circle_env
source bin/activate
```

## Postgres

`sudo service postgresql start` to start after installation.

use `attach_db.sh` to connect to db on the cli.

```
\dt  # list tables
\l   # list databases
\c <db_name>  # choose/use database
\i <sql_file_name>. # run sql file
select * from flights;
select current_database();  # show current db
```

## Book Flight

```
$ curl -d '{"dest": "LAX", "start": "2022-10-01", "end":"2022-10-01 23:00:00"}' -X POST -H "Content-Type: application/json" localhost:5000/flights/book
{
  "data": {
    "arrival": "Sat, 01 Oct 2022 21:05:00 GMT",
    "carrier": "Spirit",
    "departure": "Sat, 01 Oct 2022 16:00:00 GMT",
    "destination": "LAX",
    "id": 1,
    "price": 210,
    "source": "BOS",
    "tickets_count": 5
  }
}

$ curl localhost:5000/ping
{
  "message": "pong"
}

interview=> select * from orders;
 id | source | destination |      departure      |       arrival       | tickets_count | price | carrier |        created_time        
----+--------+-------------+---------------------+---------------------+---------------+-------+---------+----------------------------
  1 | BOS    | LAX         | 2022-10-01 16:00:00 | 2022-10-01 21:05:00 |             1 |   210 | Spirit  | 2024-11-11 01:13:38.590392
(1 row)
```