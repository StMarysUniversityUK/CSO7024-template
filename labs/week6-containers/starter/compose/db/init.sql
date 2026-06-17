-- init.sql — runs once, the first time the Postgres data volume is created.
-- It sets up a tiny schema so there is something for the application to read
-- and write once you extend it to use the database.

CREATE TABLE IF NOT EXISTS visits (
    id     SERIAL PRIMARY KEY,
    seen_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO visits (seen_at) VALUES (now());
