require 'account_repository'

RSpec.describe AccountRepository do

  def reset_accounts_table
    seed_sql = File.read('seeds/accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_accounts_table
  end

  describe '#all' do
    it 'returns all accounts' do
      repo = AccountRepository.new

      accounts = repo.all
      expect(accounts.length).to eq 2

      expect(accounts[0].id).to eq 1
      expect(accounts[0].email).to eq 'first_email@test.com'
      expect(accounts[0].username).to eq 'user_1_test' 

      expect(accounts[1].id).to eq 2
      expect(accounts[1].email).to eq 'second_email@test.com'
      expect(accounts[1].username).to eq 'user_2_test'
    end
  end

  describe '#find' do
    it 'returns the account with id 1' do
      repo = AccountRepository.new

      account = repo.find(1)

      expect(account.id).to eq 1
      expect(account.email).to eq 'first_email@test.com'
      expect(account.username).to eq 'user_1_test' 
    end

    it 'returns the account with id 2' do
      repo = AccountRepository.new

      account = repo.find(2)

      expect(account.id).to eq 2
      expect(account.email).to eq 'second_email@test.com'
      expect(account.username).to eq 'user_2_test' 
    end
  end

  describe '#create' do
    it 'adds a new account to the accounts table' do
      repo = AccountRepository.new
      
      account = Account.new
      account.email = 'third_email@test.com'
      account.username = 'user_3_test'
      
      repo.create(account)
      accounts = repo.all

      expect(accounts.length).to eq 3
      expect(accounts.last.id).to eq 3
      expect(accounts.last.email).to eq 'third_email@test.com'
      expect(accounts.last.username).to eq 'user_3_test'
    end
  end

  describe '#delete' do
    it 'deletes the account with id 1' do
      repo = AccountRepository.new

      id_to_delete = 1
      repo.delete(id_to_delete)

      accounts = repo.all

      expect(accounts.length).to eq 1
      expect(accounts.first.id).to eq 2
      expect(accounts.first.email).to eq 'second_email@test.com'
      expect(accounts.first.username).to eq 'user_2_test'
    end

    it 'deletes both accounts' do
      repo = AccountRepository.new

      id_1 = 1
      id_2 = 2

      repo.delete(id_1)
      repo.delete(id_2)

      accounts = repo.all
      expect(accounts.length).to eq 0
    end
  end
end