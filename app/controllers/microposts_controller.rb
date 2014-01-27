class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = micropost.find(params[:id]).destroy
    redirect_to root_url
  end

  def post
    @micropost = Micropost.all
  end
end
