CREATE TABLE IF NOT EXISTS rates (
  time DATETIME,
  pair VARCHAR,
  bid FLOAT,
  ask FLOAT,
  PRIMARY KEY(time, pair)
)
