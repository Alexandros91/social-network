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
end