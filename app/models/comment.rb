class Comment < ActiveRecord::Base
  attr_accessible :body
  has_many :comments, :as => :commentable
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :votable

  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end


end
