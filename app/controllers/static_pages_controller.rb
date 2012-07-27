class StaticPagesController < ApplicationController
  def show
    if File.exist? "app/views/static_pages/#{params[:page]}.html"
      render params[:page]
    else
      render '404'
    end
  end
end