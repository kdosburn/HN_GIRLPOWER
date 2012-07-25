class CommentsController < ApplicationController
  before_filter :get_parent

  def index
    @comments = Comment.all
  end

  def new
    @comment = @parent.comments.build
  end

  def create
    @comment = @parent.comments.build(params[:comment])

    if @comment.save
      redirect_to post_path(@comment.post), :notice => 'Thank you for your comment!'
    else
      render action: "new"
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "www.google.com"
  end

protected

  def get_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    redirect_to root_path unless defined?(@parent)
  end

end
