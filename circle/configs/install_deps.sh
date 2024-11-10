#!/usr/bin/env sh

# Installing PostgreSQL with extensions
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-11 \
        postgresql-client-11 \
        postgresql-contrib-11 \
        postgis \
        postgresql-11-postgis-2.5 \
    && rm -rf /var/lib/apt/lists/*

# Running postgresql server
service postgresql start

# Creating db and user with privileges
su - postgres << EOF
psql postgres << EOF2
create user interview_dbuser with password 'pass';
create database interview;
grant all privileges on database interview to interview_dbuser;
EOF2
EOF
