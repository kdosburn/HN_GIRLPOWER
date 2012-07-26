class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :id
  has_many :votes
  has_many :posts
  has_many :comments
  has_secure_password

  before_create :create_remember_token

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

# # ITERATION NINE -- KARMA
#   def karma
#     self.posts.inject(0) { |count, post| count + post.upvotes.length } +
#     self.comments.inject(0) { |count, post| count + comment.upvotes.length }
#   end

# # UPVOTE METHOD for KARMA -- eventually should go in "POST.RB"
# def upvotes
#   self.votes.where(:value => 1)
# end

private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end