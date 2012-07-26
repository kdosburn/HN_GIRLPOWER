class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def edit
    if self.been_15min?
      @post = Post.find(params[:id])
    else
      render action: "show"
    end
  end

  def index
    @posts_sorted = Post.all.sort_by { |post| - post.votes.count}
    @posts_sorted = Kaminari.paginate_array(@posts_sorted).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path
      else
        render action: "new"
      end
  end
end
