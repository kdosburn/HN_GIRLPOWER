class Comment < ActiveRecord::Base
  attr_accessible :body
  has_many :comments, :as => :commentable
  belongs_to :commentable, :polymorphic => true
  has_many :votes, :as => :votable
  belongs_to :user

  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end

  def value
    values = 0
      Comment.find(self.id).votes.each { |vote| vote.vote_value ? values += vote.vote_value : values += 0}
    values
  end

   def author
     user = User.find_by_id(self.user_id)
     user.name
   end
end
