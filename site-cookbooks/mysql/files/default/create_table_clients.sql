CREATE TABLE IF NOT EXISTS clients (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  application_id varchar(255) NOT NULL UNIQUE,
  application_key varchar(255) NOT NULL
)
