class VotesController < ApplicationController
  before_filter :get_parent, :only => [:create]

  def create
    @vote = @vote_parent.votes.build(params[:vote])
    if current_user.id == @vote_parent.user_id
      redirect_to posts_path
        flash[:error] = "You can't vote on your own comment or post!"
    elsif signed_in?
      @vote = @vote_parent.votes.build
      @vote.user_id = current_user.id
        if @vote.save
          redirect_to(@path)
        else
          @posts_sorted = Post.all.sort_by { |post| - post.votes.count}
          @posts_sorted = Kaminari.paginate_array(@posts_sorted).page(params[:page]).per(10)
          flash[:error] = "You can only vote on each comment or post once!"
          redirect_to posts_path
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

