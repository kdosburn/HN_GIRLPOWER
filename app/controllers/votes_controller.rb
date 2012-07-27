class VotesController < ApplicationController
  before_filter :get_parent, :only => [:create]

  def create
    if current_user == @vote_parent.user
      redirect_to posts_path
        flash[:error] = "You can't vote on your own comment or post!"
    elsif signed_in?
      @vote = @vote_parent.votes.build
      @vote.vote_value = params[:vote_value]
      @vote.user = current_user
        if @vote.save
          redirect_to(@path)
        else
          @post = @vote.post
          render 'posts/show'
        end
    else
      redirect_to(signin_path)
      flash[:error] = "You must sign in to vote"
    end
  end

private

def get_parent
  if params[:votable_id]
    @vote_parent = Post.find_by_id(params[:votable_id])
    @path = posts_path
  elsif params[:comment_id]
    @vote_parent = Comment.find_by_id(params[:comment_id])
    @path = post_path(@vote_parent.post)
  else
    redirect_to root_path unless defined?(@vote_parent)
  end
end


end

