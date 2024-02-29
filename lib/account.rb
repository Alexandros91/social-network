class Account

  attr_accessor :id, :email, :username, :posts

  def initialize
    @posts = []
  end
end