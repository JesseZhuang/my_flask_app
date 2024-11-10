-- Create a flights table
CREATE TABLE IF NOT EXISTS flights (
    id              INT PRIMARY KEY NOT NULL,
    source          TEXT NOT NULL,
    destination     TEXT NOT NULL,
    departure       TIMESTAMP NOT NULL DEFAULT NOW(),
    arrival         TIMESTAMP NOT NULL DEFAULT NOW(),
    tickets_count   INT NOT NULL,
    price           INT NOT NULL,
    carrier         TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id              INT PRIMARY KEY NOT NULL,
    source          TEXT NOT NULL,
    destination     TEXT NOT NULL,
    departure       TIMESTAMP NOT NULL DEFAULT NOW(),
    arrival         TIMESTAMP NOT NULL DEFAULT NOW(),
    tickets_count   INT NOT NULL,
    price           INT NOT NULL,
    carrier         TEXT NOT NULL,
    created_time    TIMESTAMP NOT NULL DEFAULT NOW()
);