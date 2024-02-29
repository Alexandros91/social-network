require_relative './account'

class AccountRepository

  def all
    sql = 'SELECT id, email, username FROM accounts;'
    
    result_set = DatabaseConnection.exec_params(sql, [])

    accounts = []

    result_set.each do |record|
      account = Account.new
      account.id = record['id'].to_i
      account.email = record['email']
      account.username = record['username']

      accounts << account
    end

    return accounts
  end

  def find(id)
    sql = 'SELECT id, email, username FROM accounts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]
      
    account = Account.new
    account.id = record['id'].to_i
    account.email = record['email']
    account.username = record['username']

    return account
  end

  def create(account)
    sql = 'INSERT INTO accounts (email, username) VALUES ($1, $2);'
    sql_params = [account.email, account.username]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(account)
    sql = 'UPDATE accounts SET email = $1, username = $2 WHERE id = $3;'
    sql_params = [account.email, account.username, account.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find_with_posts(account_id)
    sql = 'SELECT accounts.id AS "account_id",
    accounts.email AS "email",
    accounts.username AS "username",
    posts.title AS "title",
    posts.content AS "content",
    posts.views AS "views"
    FROM accounts
    JOIN posts
    ON  accounts.id = posts.account_id
    WHERE accounts.id = $1;'
    sql_params = [account_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    first_record = result_set[0]

    account = record_to_account_object(first_record)

    result_set.each do |record|
      account.posts << record_to_post_object(record)
    end
  
    return account
  end

  private

  def record_to_account_object(record)
    account = Account.new
    account.id = record['account_id'].to_i
    account.email = record['email']
    account.username = record['username']

    return account
  end

  def record_to_post_object(record)
    post = Post.new
    post.id = record['post_id'].to_i
    post.title = record['title']
    post.content = record['content']
    post.views = record['views'].to_i

    return post
  end

end