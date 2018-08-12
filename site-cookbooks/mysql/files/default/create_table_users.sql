CREATE TABLE IF NOT EXISTS users (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  user_id varchar(255) NOT NULL UNIQUE,
  password varchar(255) NOT NULL
)
