# Posts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `posts`*

```
# EXAMPLE

Table: posts

Columns:
id | title | content | account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: seeds/posts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table title.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, account_id) VALUES ('First test title', 'First test content', 1);
INSERT INTO posts (title, content, account_id) VALUES ('Second test title', 'Second test content', 2);
INSERT INTO posts (title, content, account_id) VALUES ('Third test title', 'Third test content', 2);
INSERT INTO posts (title, content, account_id) VALUES ('Fourth test title', 'Fourth test content', 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < posts.sql
```

## 3. Define the class titles

Usually, the Model class title will be the capitalised table title (single instead of plural). The same title is then suffixed by `Repository` for the Repository class title.

```ruby
# EXAMPLE
# Table title: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table title: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :account_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# post = post.new
# post.title = 'Jo'
# post.title
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table title: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, account_id FROM posts;

    # Returns an array of post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, account_id FROM posts WHERE id = $1;

    # Returns a single post object.
  end

  # Add more methods below for each operation you'd like to implement.

    # Inserts a new post record
    # Takes an post object as an argument
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, account_id) VALUES ($1, $2, $3);

    # Returns nothing (only creates the post record)
  end

  # def update(post)
  # end

  # def delete(post)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all
posts.length # =>  4

posts[0].id # =>  1
posts[0].title # =>  'First test title'
posts[0].content # =>  'First test content'
posts[0].account_id # =>  1

posts[1].id # =>  2
posts[1].title # =>  'Second test title'
posts[1].content # =>  'Second test content'
posts[1].account_id # =>  2

posts[2].id # =>  3
posts[2].title # =>  'Third test title'
posts[2].content # =>  'Third test content'
posts[2].account_id # =>  2

posts[3].id # =>  4
posts[3].title # =>  'Fourth test title'
posts[3].content # =>  'Fourth test content'
posts[3].account_id # =>  1


# 2
# Get a single post

repo = postRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'First test title'
post.content # =>  'First test content'
post.account_id # => 1

# 3
# Get another post

repo = postRepository.new

post = repo.find(2)

post.id # =>  2
post.title # =>  'Second test title'
post.content # =>  'Second test content'
post.account_id # => 2

# 4
# Get another post

repo = postRepository.new

post = repo.find(3)

post.id # =>  3
post.title # =>  'Third test title'
post.content # =>  'Third test content'
post.account_id # => 2

# 5
# Get another post

repo = postRepository.new

post = repo.find(4)

post.id # =>  4
post.title # =>  'Fourth test title'
post.content # =>  'Fourth test content'
post.account_id # => 1

# Add more examples for each method

# 6
# Create a new post

repo = postRepository.new
posts = repo.all

post = post.new
post.title = 'Fifth test title'
post.content = 'Fifth test content'
post.account_id = 3

repo.create(post)

posts.length # => 5
posts.last.id # => 5
posts.last.title # => 'Fifth test title'
posts.last.content # => 'Fifth test content'
posts.last.account_id # => 5

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('seeds/posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe postRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->