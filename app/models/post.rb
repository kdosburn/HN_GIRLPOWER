# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
  attr_accessible :title, :url
  has_many :votes

  validates_uniqueness_of :url
  validates_presence_of :title, :url

  paginates_per 4

  def been_15min?
    @post = Post.find(params[:id])
     (Time.now - @post.created_at) < 900
   end
end
