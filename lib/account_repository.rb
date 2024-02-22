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

    return
  end

  def delete(id)
    sql = 'DELETE FROM accounts WHERE id = $1'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  # def update(account)

  # end

end