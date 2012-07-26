class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :posts_by_votes
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable
  belongs_to :user

  validates_uniqueness_of :url
  validates_presence_of :title, :url
  validates :url, :format => {:with => /(http:\/\/|https:\/\/)/, :message => "Add an http:// or https:// to your URL!"}

  def been_15min?
    @post = Post.find(params[:id])
     (Time.now - @post.created_at) < 900
   end

   def self.random_post
     if (c = count) != 0
       find(:first, :offset =>rand(c))
     end
   end


end
