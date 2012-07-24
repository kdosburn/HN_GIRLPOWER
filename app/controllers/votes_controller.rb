include ApplicationHelper

  class VotesController < ApplicationController

    def create
        post = Post.find(params[:post_id])
        user = current_user
      if user.id == post.user_id
        redirect_to posts_path, :notice => "Can't vote on your own post"
      elsif signed_in?
        vote = post.votes.build
        vote.user_id = user.id
        vote.save!
        redirect_to(posts_path)
      else
        redirect_to(signin_path)
      end
    end
  end

