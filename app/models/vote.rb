class Vote < ActiveRecord::Base

  attr_accessible :post_id, :user_id
  belongs_to :post
  belongs_to :user

  validates_uniqueness_of :post_id, {:scope => :user_id, :message => "you've already voted on this!"}

end
