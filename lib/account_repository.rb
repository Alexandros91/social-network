require_relative './account'

class AccountRepository

  # Selecting all records
  # No arguments
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

  # # Gets a single record by its ID
  # # One argument: the id (number)
  # def find(id)
  #   # Executes the SQL query:
  #   # SELECT id, email, username FROM accounts WHERE id = $1;

  #   # Returns a single account object.
  # end

  # # Add more methods below for each operation you'd like to implement.

  #   # Inserts a new account record
  #   # Takes an account object as an argument
  # def create(account)
  #   # Executes the SQL query:
  #   # INSERT INTO accounts (email, username) VALUES ($1, $2);

  #   # Returns nothing (only creates the account record)
  # end

  # def update(account)
  # end

  # def delete(account)
  # end
end