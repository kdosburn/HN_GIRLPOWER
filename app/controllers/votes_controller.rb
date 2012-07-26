class VotesController < ApplicationController
  # before_filter :get_this_parent, :only => [:create]

  def create
      parent = Post.find(params[:votable_id]) || parent = Comment.find(params[:votable_id])
    if current_user.id == post.user_id
      redirect_to posts_path
        flash[:error] = "You can't vote on your own post!"
    elsif signed_in?
      @vote = parent.votes.build
      @vote.user_id = current_user.id

        if @vote.save
          redirect_to(posts_path)
        else
          @posts_sorted = Post.all.sort_by { |post| - post.votes.count}
          @posts_sorted = Kaminari.paginate_array(@posts_sorted).page(params[:page]).per(10)
          flash[:error] = "You can only vote on each post once!"
          redirect_to posts_path
        end
    else
      redirect_to(signin_path)
    end
  end



private

  def get_this_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    # @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end


end

