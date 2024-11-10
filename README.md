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

use `attach_db.sh` to connect to db on the cli.

```
\dt  # list tables
\l   # list databases
\c <db_name>  # choose/use database
\i <sql_file_name>. # run sql file
Select * from flights;  # note capital S
```