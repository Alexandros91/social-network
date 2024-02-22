require 'post_repository'

RSpec.describe PostRepository do

  def reset_posts_table
    seed_sql = File.read('seeds/posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_posts_table
  end

  describe '#all' do
    it 'returns all posts' do
      repo = PostRepository.new

      posts = repo.all
      expect(posts.length).to eq 4

      expect(posts[0].id).to eq 1
      expect(posts[0].title).to eq 'First test title'
      expect(posts[0].content).to eq 'First test content'
      expect(posts[0].views).to eq 30
      expect(posts[0].account_id).to eq 1

      expect(posts[1].id).to eq 2
      expect(posts[1].title).to eq 'Second test title'
      expect(posts[1].content).to eq 'Second test content'
      expect(posts[1].views).to eq 34
      expect(posts[1].account_id).to eq 2

      expect(posts[2].id).to eq 3
      expect(posts[2].title).to eq 'Third test title'
      expect(posts[2].content).to eq 'Third test content'
      expect(posts[2].views).to eq 19
      expect(posts[2].account_id).to eq 2

      expect(posts[3].id).to eq 4
      expect(posts[3].title).to eq 'Fourth test title'
      expect(posts[3].content).to eq 'Fourth test content'
      expect(posts[3].views).to eq 14
      expect(posts[3].account_id).to eq 1
    end
  end
end