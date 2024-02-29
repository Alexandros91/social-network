TRUNCATE TABLE accounts RESTART IDENTITY; -- replace with your own table email.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('first_email@test.com', 'user_1_test');
INSERT INTO accounts (email, username) VALUES ('second_email@test.com', 'user_2_test');

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, account_id) VALUES ('First test title', 'First test content', 30, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('Second test title', 'Second test content', 34, 2);
INSERT INTO posts (title, content, views, account_id) VALUES ('Third test title', 'Third test content', 19, 2);
INSERT INTO posts (title, content, views, account_id) VALUES ('Fourth test title', 'Fourth test content', 14, 1);