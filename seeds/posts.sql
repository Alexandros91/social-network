TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, account_id) VALUES ('First test title', 'First test content', 1);
INSERT INTO posts (title, content, account_id) VALUES ('Second test title', 'Second test content', 2);
INSERT INTO posts (title, content, account_id) VALUES ('Third test title', 'Third test content', 2);
INSERT INTO posts (title, content, account_id) VALUES ('Fourth test title', 'Fourth test content', 1);