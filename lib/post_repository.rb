require_relative './post'

class PostRepository

  def all
    sql = 'SELECT id, title, content, views, account_id FROM posts;'

    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id'].to_i
      post.title = record['title']
      post.content = record['content']
      post.views = record['views'].to_i
      post.account_id = record['account_id'].to_i

      posts << post
    end

    return posts
  end


  def find(id)
    sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    post = Post.new
    post.id = record['id'].to_i
    post.title = record['title']
    post.content = record['content']
    post.views = record['views'].to_i
    post.account_id = record['account_id'].to_i

    return post
  end
end