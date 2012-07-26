class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :posts_by_votes
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable
  belongs_to :user

  # scope :highest_rated, includes(:votes).group('post_id').order('ASC')

  validates_uniqueness_of :url
  validates_presence_of :title, :url
  validates :url, :format => {:with => /(http:\/\/|https:\/\/)/ }

  def been_15min?
    @post = Post.find(params[:id])
     (Time.now - @post.created_at) < 900
   end

   def self.random_post
      @random_post = rand(0..Post.all.length)
      if !Post.exists?(@random_post)
        random_post
      else
        @random_post
      end
  end




end
