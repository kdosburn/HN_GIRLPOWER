class VotesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    vote = post.votes.build
    vote.save!
    redirect_to(posts_path)
  end
end
