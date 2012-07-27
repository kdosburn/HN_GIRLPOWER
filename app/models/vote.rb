class Vote < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :votable_id
  belongs_to :user
  belongs_to :votable, :polymorphic => true

  validates_uniqueness_of :votable_id, {:scope => :user_id, :message => "you've already voted on this!"}

  def post
    return @post if defined?(@post)
    @post = votable.is_a?(Post) ? votable : votable.post
  end

end


# <%= link_to "VOTE-VALUE-BUTTON", votes_path(params.merge(:vote_value => 2)) %>


# QUESTION: How do we use def create to define the vote value?
# EX: input "+1" Vote.create(:vote_value => "positive")
# EX: input "-1" Vote.create(:vote_value => "negative")