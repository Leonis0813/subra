CREATE TABLE IF NOT EXISTS cookies (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  value varchar(255) NOT NULL UNIQUE,
  user_id int(11) NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE (value, user_id)
)
