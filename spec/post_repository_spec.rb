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

  describe '#find' do
    it 'returns the post with id 1' do
      repo = PostRepository.new

      post = repo.find(1)

      expect(post.id).to eq 1
      expect(post.title).to eq 'First test title'
      expect(post.content).to eq 'First test content'
      expect(post.views).to eq 30
      expect(post.account_id).to eq 1
    end

    it 'returns the post with id 3' do
      repo = PostRepository.new

      post = repo.find(3)

      expect(post.id).to eq 3
      expect(post.title).to eq 'Third test title'
      expect(post.content).to eq 'Third test content'
      expect(post.views).to eq 19
      expect(post.account_id).to eq 2
    end
  end

  describe '#create' do
    it 'adds a post to the posts table' do
      repo = PostRepository.new

      new_post = Post.new
      new_post.id = 5
      new_post.title = 'Fifth test title'
      new_post.content = 'Fifth test content'
      new_post.views = 4
      new_post.account_id = 1

      repo.create(new_post)
      posts = repo.all
      last_post = posts.last

      expect(posts.length).to eq 5
      expect(last_post.id).to eq 5
      expect(last_post.title).to eq 'Fifth test title'
      expect(last_post.content).to eq 'Fifth test content'
      expect(last_post.views).to eq 4
      expect(last_post.account_id).to eq 1
    end
  end

  describe '#delete' do
    it 'deletes the post with id 1 from the posts table' do
      repo = PostRepository.new

      id_to_delete = 1
      repo.delete(id_to_delete)

      posts = repo.all
      first_post = posts.first

      expect(posts.length).to eq 3
      expect(first_post.id).to eq 2
      expect(first_post.title).to eq 'Second test title'
      expect(first_post.content).to eq 'Second test content'
      expect(first_post.views).to eq 34
      expect(first_post.account_id).to eq 2
    end

    it 'deletes all posts from the posts table' do
      repo = PostRepository.new
      
      repo.delete(1)
      repo.delete(2)
      repo.delete(3)
      repo.delete(4)

      posts = repo.all
      expect(posts.length).to eq 0
    end
  end
end