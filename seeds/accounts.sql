TRUNCATE TABLE accounts RESTART IDENTITY; -- replace with your own table email.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('first_email@test.com', 'user_1_test');
INSERT INTO accounts (email, username) VALUES ('second_email@test.com', 'user_2_test');