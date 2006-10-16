
ALTER TABLE clients CHANGE `client_strasse` `client_strasse` VARCHAR(50);
ALTER TABLE clients CHANGE `client_ort` `client_ort` VARCHAR(50);
ALTER TABLE users CHANGE `user_name` `user_name` VARCHAR(50);
ALTER TABLE users CHANGE `user_vorname` `user_vorname` VARCHAR(25);
ALTER TABLE users CHANGE `user_strasse` `user_strasse` VARCHAR(50);
ALTER TABLE users CHANGE `user_ort` `user_ort` VARCHAR(50);
ALTER TABLE users CHANGE `user_klasse` `user_klasse` VARCHAR(25);

