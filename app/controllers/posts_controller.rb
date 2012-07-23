class PostsController < ApplicationController
  def _form
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
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
      if @post.save
        redirect_to @post
      else
        render action: "new"
      end
  end
end
