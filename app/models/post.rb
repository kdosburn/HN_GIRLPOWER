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

   def author
     user = User.find_by_id(self.user_id)
     user.name
   end

    def self.ordered_by(param)
       case param
       when 'title'     then Article.order('title')
       when 'published' then Article.order('created_at DESC')
         # length of body - all the spaces from the body = pseudo word count (body + body - spaces)
         # Article.order('LENGTH(body)') <-- small version
       when 'word_count'then Article.order('(LENGTH(body) - (LENGTH(REPLACE(body, " ", "")))) DESC')
       else                  Article.all
     end
   end

   def value
     values = 0
       Post.find(self.id).votes.each { |vote| vote.vote_value ? values += vote.vote_value : values += 0}
     values
   end

end
