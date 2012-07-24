include ApplicationHelper

  class PostsController < ApplicationController
    def _form
    end

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
      @posts = Post.page params[:page]

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
      user = current_user
        if @post.save
          redirect_to posts_path
        else
          render action: "new"
        end
    end
  end
