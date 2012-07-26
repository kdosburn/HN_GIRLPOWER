class Vote < ActiveRecord::Base

  attr_accessible :post_id, :user_id, :votable_id
  belongs_to :user
  belongs_to :votable, :polymorphic => true

  validates_uniqueness_of :votable_id, {:scope => :user_id, :message => "you've already voted on this!"}

end
