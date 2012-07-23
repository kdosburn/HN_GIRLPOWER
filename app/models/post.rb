class Post < ActiveRecord::Base
  attr_accessible :title, :url

  validates_uniqueness_of :url
  validates_presence_of :title, :url

  paginates_per 25
end
